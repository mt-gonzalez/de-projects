import os
from pathlib import Path
from dotenv import load_dotenv

dotenv_path = os.path.join(os.path.dirname(__file__), "..", "..", ".env")
load_dotenv(dotenv_path=dotenv_path)

os.environ['KAGGLE_USERNAME'] = os.getenv('KAGGLE_USERNAME')
os.environ['KAGGLE_KEY'] = os.getenv('KAGGLE_API_KEY')

from kaggle.api.kaggle_api_extended import KaggleApi # The api looks for credentials when charged

api = KaggleApi()
api.authenticate()

DATASET = "mkechinov/ecommerce-events-history-in-electronics-store"
OUTPUT_DIR = "./ingestion/source/"

api.dataset_download_files(DATASET, path=OUTPUT_DIR, unzip=True)

print(f"Dataset downloaded to {OUTPUT_DIR}")

