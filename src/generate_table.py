import csv
import random
from faker import Faker
import pandas as pd
from sqlalchemy import create_engine

# Inisialisasi Faker
fake = Faker()

# Create connection to PostgreSQL
def create_postgres_engine():
    user = 'postgres'  # Ganti dengan username PostgreSQL Anda
    password = 'alwisihab'  # Ganti dengan password PostgreSQL Anda
    host = 'localhost'
    port = '5432'
    database = 'postgres'
    
    return create_engine(f'postgresql+psycopg2://{user}:{password}@{host}:{port}/{database}')

# Save DataFrames to PostgreSQL
def save_to_postgres(df, table_name, engine):
    df.to_sql(table_name, engine, if_exists='replace', index=False)

# Export DataFrames to CSV
def export_to_csv(df, filename):
    df.to_csv(f'{filename}.csv', index=False)
    print(f'Data berhasil diexport ke {filename}.csv')

# Generate city data
def generate_cities():
    JABODETABEK_CITIES = [
        ('Jakarta', -6.2088, 106.8456),
        ('Bogor', -6.5916, 106.8060),
        ('Depok', -6.4025, 106.7942),
        ('Tangerang', -6.1702, 106.6319),
        ('Bekasi', -6.2417, 106.9920)
    ]
    cities_data = []
    for city_id, (city_name, lat, lon) in enumerate(JABODETABEK_CITIES, start=1):
        cities_data.append([city_id, city_name, lat, lon])
    cities_df = pd.DataFrame(cities_data, columns=['city_id', 'city_name', 'latitude', 'longitude'])
    return cities_df

# Generate users
def generate_users(num_users):
    users_data = []
    for user_id in range(1, num_users + 1):
        users_data.append([
            user_id, 
            fake.name(),
            fake.phone_number(),
            random.randint(1, 5)  # Mengambil city_id dari 1-5 untuk Jabodetabek
        ])
    users_df = pd.DataFrame(users_data, columns=['user_id', 'name', 'contact', 'city_id'])
    return users_df

# Generate cars
def generate_cars(num_cars):
    BRANDS = ['Toyota', 'Daihatsu', 'Honda']
    MODELS = ['Camry', 'Corolla Altis', 'Vios', 'Camry Hybrid']
    BODY_TYPES = ['MPV', 'SUV', 'Van', 'Sedan', 'Hatchback']
    cars_data = []
    for product_id in range(1, num_cars + 1):
        cars_data.append([
            product_id,
            random.choice(BRANDS),
            random.choice(MODELS),
            random.choice(BODY_TYPES),
            random.randint(2000, 2021),
            round(random.uniform(50000000, 300000000), 2),
            random.randint(1, 5),  # city_id antara 1-5
            random.randint(1, 20),  # user_id antara 1-20
            fake.text()
        ])
    cars_df = pd.DataFrame(cars_data, columns=['product_id', 'brand', 'model', 'body_type', 'year', 'price', 'city_id', 'user_id', 'description'])
    return cars_df

# Generate ads
def generate_ads(num_ads):
    ads_data = []
    for ad_id in range(1, num_ads + 1):
        ads_data.append([
            ad_id, 
            f'Iklan {ad_id}', 
            ad_id,  # product_id yang sesuai dengan ad_id
            random.randint(1, 20),  # user_id antara 1-20
            random.choice([True, False])
        ])
    ads_df = pd.DataFrame(ads_data, columns=['ad_id', 'title', 'product_id', 'user_id', 'allow_bid'])
    return ads_df

# Generate bids
def generate_bids(num_bids):
    bids_data = []
    for bid_id in range(1, num_bids + 1):
        bids_data.append([
            bid_id,
            random.randint(1, 50),  # product_id antara 1-50
            random.randint(1, 20),  # user_id antara 1-20
            round(random.uniform(50000000, 300000000), 2),  # Harga tawar dalam range 50 juta hingga 300 juta
            fake.date_time_this_year(),  # tanggal bid
        ])
    bids_df = pd.DataFrame(bids_data, columns=['bid_id', 'product_id', 'user_id', 'bid_price', 'bid_date'])
    return bids_df

# Main
def main():
    num_records = 50
    
    cities_df = generate_cities()
    users_df = generate_users(num_records)
    cars_df = generate_cars(num_records)
    ads_df = generate_ads(num_records)
    bids_df = generate_bids(num_records)
    
    engine = create_postgres_engine()
    
    # Save to PostgreSQL
    save_to_postgres(cities_df, 'cities', engine)
    save_to_postgres(users_df, 'users', engine)
    save_to_postgres(cars_df, 'cars', engine)
    save_to_postgres(ads_df, 'ads', engine)
    save_to_postgres(bids_df, 'bids', engine)
    
    # Export to CSV
    export_to_csv(cities_df, 'cities')
    export_to_csv(users_df, 'users')
    export_to_csv(cars_df, 'cars')
    export_to_csv(ads_df, 'ads')
    export_to_csv(bids_df, 'bids')
    
    print("Data successfully inserted into PostgreSQL and exported to CSV!")

if __name__ == '__main__':
    main()