# Used Car Sales Database System
![erd](https://github.com/user-attachments/assets/114b6f19-b330-4acf-971a-86afc3892748)

## Project Overview

This project involves creating a used car sales system with a PostgreSQL database. The system includes functionality for managing cities, users, cars, ads, and bids. Data is generated using Python and Faker, and imported into PostgreSQL. Additionally, the data is exported to CSV files for backup and analysis.

## Project Structure

- **Database Schema**: 
  - `cities`: Stores information about cities.
  - `users`: Contains user details.
  - `cars`: Holds details about cars for sale.
  - `ads`: Manages ads for cars.
  - `bids`: Records bids placed on cars.

- **Python Scripts**:
  - `data_generator.py`: Generates and exports data to CSV files.
  - `db_operations.py`: Contains functions for creating tables and importing CSV data into PostgreSQL.

## Setup

1. **Install Dependencies**

   Make sure you have the necessary Python libraries installed. You can use `pip` to install them:
   
   ```bash
   pip install pandas sqlalchemy psycopg2 faker
   
2. **Install required packages**

   ```bash
    pip install pandas Faker sqlalchemy psycopg2-binary

3. **Install PostgreSQL**

    If you don't have PostgreSQL installed, you can install it using Homebrew (for macOS):


    ```bash
    brew install postgresql

4. **Configure PostgreSQL**

    Make sure PostgreSQL is running and accessible with the appropriate credentials. Update the connection details in the create_postgres_engine function of the script.


## Usage

**Clone the repository**:

    ```bash
    git clone https://github.com/abagasw/Online-Used-Car-Sales-Database-System.git
    cd Online-Used-Car-Sales-Database-System


Modify the database connection parameters in generate_table.py as needed:


    ```bash
    def create_postgres_engine():
        user = 'postgres'      # Your PostgreSQL username
        password = 'alwisihab' # Your PostgreSQL password
        host = 'localhost'
        port = '5432'
        database = 'postgres'
        
        return create_engine(f'postgresql+psycopg2://{user}:{password}@{host}:{port}/{database}')


Run the script to generate data, save it to PostgreSQL, and export it to CSV:

    ```bash
    
    python generate_table.py

## Data Generation

  The script generates dummy data for the following tables:

  - `cities`: Contains city information (city_id, city_name, latitude, longitude).
  - `users`: Contains user information (user_id, name, contact, city_id).
  - `cars`: Contains car information (product_id, brand, model, body_type, year, price, city_id, user_id, description).
  - `ads`: Contains ad information (ad_id, title, product_id, user_id, allow_bid).
  - `bids`: Contains bid information (bid_id, product_id, user_id, bid_price, bid_date).
  
## Generated Data and CSV Export

After running the script, the data is saved to the PostgreSQL database and exported to the following CSV files:

   - `cities.csv`
   - `users.csv`
   - `cars.csv`
   - `ads.csv`
   - `bids.csv`


## SQL Queries

  Several SQL queries are included for analytical purposes:


**Transactional Queries**
  - Find cars manufactured from 2015 onwards
  - Add a new bid for a product
  - View all cars sold by a specific user, sorted by the newest
  - Find the cheapest used car based on a keyword
  - Find the nearest used car based on a city ID, using Euclidean distance


**Analytical Queries**
  - Rank car model popularity based on the number of bids
  - Compare car prices based on average price per city
  - Compare bid timestamps and amounts for a specific car model
  - Compare average car model prices with average bid prices over the last six months
  - Use a window function to calculate the average bid price for a brand and model over the last six months


## License

This project is licensed under the MIT License. See LICENSE for more information.


## Acknowledgments
- Faker Library: For generating realistic dummy data.
- Pandas Library: For data manipulation and CSV handling.
- SQLAlchemy Library: For SQL toolkit and Object Relational Mapper (ORM).
- psycopg2: For PostgreSQL database adapter for Python.
