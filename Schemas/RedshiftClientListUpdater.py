import boto3
import psycopg2
import logging
import json
import requests
import os
from requests.adapters import HTTPAdapter
from requests.packages.urllib3.util.retry import Retry

# Constants
API_URL = 'https://api.example.com/clients'  # Replace with your API URL
DB_PARAMS = {'dbname': 'your_dbname', 'user': 'your_user', 'password': 'your_password', 'host': 'your_host'}  # Replace with your database parameters
AWS_SECRET_NAME = os.environ.get('AWS_SECRET_NAME', 'your_redshift_secret')  # Use environment variable or default

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def get_db_credentials(secret_name):
    client = boto3.client('secretsmanager')
    try:
        get_secret_value_response = client.get_secret_value(SecretId=secret_name)
        secret = get_secret_value_response['SecretString']
        return json.loads(secret)
    except Exception as e:
        logging.error(f"Error retrieving secret: {e}")
        raise

def requests_retry_session(retries=3, backoff_factor=0.3, status_forcelist=(500, 502, 504)):
    session = requests.Session()
    retry = Retry(
        total=retries,
        read=retries,
        connect=retries,
        backoff_factor=backoff_factor,
        status_forcelist=status_forcelist,
    )
    adapter = HTTPAdapter(max_retries=retry)
    session.mount('http://', adapter)
    session.mount('https://', adapter)
    return session

def fetch_client_ids_from_api():
    try:
        session = requests_retry_session()
        response = session.get(API_URL)
        response.raise_for_status()
        clients = response.json()
        return [client['client_id'] for client in clients]
    except requests.RequestException as e:
        logging.error(f"Error fetching client IDs from API: {e}")
        return []

def fetch_client_ids_from_database():
    try:
        with psycopg2.connect(**DB_PARAMS) as conn:
            with conn.cursor() as cur:
                cur.execute("SELECT client_id FROM your_client_table")
                return [row[0] for row in cur.fetchall()]
    except psycopg2.DatabaseError as e:
        logging.error(f"Database operation failed: {e}")
        return []

def fetch_client_ids_from_source():
    # Choose the appropriate source fetching function
    # return fetch_client_ids_from_api()
    return fetch_client_ids_from_database()

def update_client_list_in_redshift(client_ids, db_credentials):
    if not client_ids:
        logging.warning("No client IDs provided for updating.")
        return

    try:
        with psycopg2.connect(**db_credentials) as conn:
            with conn.cursor() as cur:
                for client_id in client_ids:
                    cur.execute("INSERT INTO master_schema.client_list (client_id) VALUES (%s) ON CONFLICT (client_id) DO NOTHING;", (client_id,))
                conn.commit()
                logging.info(f"{len(client_ids)} client IDs processed.")
    except psycopg2.DatabaseError as e:
        logging.error(f"Database operation failed: {e}")

def main():
    try:
        db_credentials = get_db_credentials(AWS_SECRET_NAME)
        client_ids = fetch_client_ids_from_source()
        update_client_list_in_redshift(client_ids, db_credentials)
    except Exception as e:
        logging.error(f"An error occurred in main: {e}")

if __name__ == "__main__":
    main()
