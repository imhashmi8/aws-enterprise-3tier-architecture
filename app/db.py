import pymysql
import os
import time

def get_db_connection():
    retries = 5
    while retries > 0:
        try:
            return pymysql.connect(
                host=os.getenv("DB_HOST"),
                user=os.getenv("DB_USER"),
                password=os.getenv("DB_PASSWORD"),
                database=os.getenv("DB_NAME"),
                cursorclass=pymysql.cursors.Cursor
            )
        except Exception as e:
            print(f"Database not ready, retrying... {e}")
            retries -= 1
            time.sleep(5)
    raise Exception("Database connection failed after retries")