import mysql.connector

def prepare_mysql_server():
    # Database and user information
    db_name = 'hbnb_dev_db'
    username = 'hbnb_dev'
    password = 'hbnb_dev_pwd'

    # Connect to MySQL server (assuming it's running on localhost with default port)
    try:
        connection = mysql.connector.connect(
            host='localhost',
            user='root',  # Provide the MySQL server username with sufficient privileges
            password='your_root_password'  # Replace with your actual MySQL server root password
        )

        cursor = connection.cursor()

        # Create database if not exists
        cursor.execute(f"CREATE DATABASE IF NOT EXISTS {db_name};")

        # Create user if not exists
        cursor.execute(f"CREATE USER IF NOT EXISTS '{username}'@'localhost' IDENTIFIED BY '{password}';")

        # Grant privileges to the user
        cursor.execute(f"GRANT ALL PRIVILEGES ON {db_name}.* TO '{username}'@'localhost';")
        cursor.execute("FLUSH PRIVILEGES;")

        # Grant SELECT privilege on performance_schema
        cursor.execute("GRANT SELECT ON performance_schema.* TO 'hbnb_dev'@'localhost';")
        cursor.execute("FLUSH PRIVILEGES;")

        print("MySQL server prepared successfully.")

    except mysql.connector.Error as err:
        print(f"Error: {err}")
    
    finally:
        # Close the cursor and connection
        if connection.is_connected():
            cursor.close()
            connection.close()

if __name__ == "__main__":
    prepare_mysql_server()
