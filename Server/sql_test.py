import mysql.connector

mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="14072003jp",
    database="test"
)
cursor = mydb.cursor()
import mysql.connector
cursor.execute("select * from ct_2020_batch1_att")
s = cursor.fetchall()
print(s)
