import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt

# Step 1: Connect to MySQL
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Shifa",  # Change this
    database="social_media_analytics"
)

print("Connected Successfully!")

# Step 2: Run SQL Query
query = """
SELECT u.username, COUNT(p.post_id) AS total_posts
FROM users u
LEFT JOIN posts p ON u.user_id = p.user_id
GROUP BY u.username
ORDER BY total_posts DESC;
"""

df = pd.read_sql(query, conn)

print(df)

# Step 3: Plot Graph
plt.bar(df['username'], df['total_posts'])
plt.xlabel("Users")
plt.ylabel("Number of Posts")
plt.title("Most Active Users")
plt.show()

conn.close()
print("Connection Closed")