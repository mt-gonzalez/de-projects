import os
import psycopg2
from pathlib import Path
from dotenv import load_dotenv

dotenv_path = os.path.join(os.path.dirname(__file__), "..", "..", ".env")
load_dotenv(dotenv_path=dotenv_path)

DB_CONFIG = {
    "host": "localhost",
    "port": 5432,
    "dbname": os.getenv('POSTGRES_DB'),
    "user": os.getenv('POSTGRES_USER'),
    "password": os.getenv('POSTGRES_PASSWORD')
}

CSV_PATH = Path('./ingestion/source/events.csv')

TABLE_NAME = "raw.events"
COLUMNS = """
event_time,
event_type,
product_id,
category_id,
category_code,
brand,
price,
user_id,
user_session
"""

def get_connection() :
    return psycopg2.connect(**DB_CONFIG)

# --- Check table exists ---
def check_table_exists(conn):
    with conn.cursor() as cur:
        cur.execute("""
            SELECT EXISTS (
                SELECT 1
                FROM information_schema.tables
                WHERE table_schema = 'raw'
                  AND table_name = 'events'
            );
        """)
        exists = cur.fetchone()[0]

        if not exists:
            raise Exception("Table raw.events does not exist")

# --- Load CSV ---
def load_csv(conn):
    with conn.cursor() as cur:
        with open(CSV_PATH, "r") as f:
            cur.copy_expert(
                f"""
                COPY {TABLE_NAME} ({COLUMNS})
                FROM STDIN
                WITH CSV HEADER
                """,
                f
            )
    conn.commit()

# --- Validate load ---
def validate(conn):
    with conn.cursor() as cur:
        cur.execute("SELECT COUNT(*) FROM raw.events;")
        count = cur.fetchone()[0]
        print(f"✅ Rows in raw.events: {count}")

# --- Main ---
def main():

    print("Connecting to database...")
    print("DB:", DB_CONFIG["dbname"])
    print("User:", DB_CONFIG["user"])
    print("CSV path:", CSV_PATH)
    print("File exists:", CSV_PATH.exists())

    conn = get_connection()

    try:
        print("Checking table exists...")
        check_table_exists(conn)

        print("Loading CSV...")
        load_csv(conn)

        print("Validating load...")
        validate(conn)

        print("✅ Load completed successfully")

    except Exception as e:
        print(f"❌ Error: {e}")
        conn.rollback()

    finally:
        conn.close()


if __name__ == "__main__":
    main()