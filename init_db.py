import mysql.connector

from dotenv import load_dotenv
import os

load_dotenv()

DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_USER = os.getenv("DB_USER")
DB_HOST = os.getenv("DB_HOST")
DB_NAME = os.getenv("DB_NAME")

conn = mysql.connector.connect(
    host=DB_HOST,
    user=DB_USER,
    password=DB_PASSWORD
)
cursor = conn.cursor()

cursor.execute(f"CREATE DATABASE IF NOT EXISTS {DB_NAME}")
cursor.execute(f"USE {DB_NAME}")

with open("database/models.sql", "r") as f:
    sql_commands = f.read()

for command in sql_commands.split(";"):
    if command.strip():
        cursor.execute(command)

conn.commit()
cursor.close()
conn.close()

print("Database initialized.")
