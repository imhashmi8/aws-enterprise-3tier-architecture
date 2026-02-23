from flask import Flask, render_template, jsonify
from db import get_db_connection
import os
import logging

app = Flask(__name__)

logging.basicConfig(level=logging.INFO)

@app.route("/")
def home():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT NOW();")
        result = cursor.fetchone()
        conn.close()
        return render_template("index.html", db_time=result[0])
    except Exception as e:
        logging.error(f"Database connection failed: {e}")
        return "Database connection failed", 500


@app.route("/health")
def health():
    return jsonify({"status": "healthy"}), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)