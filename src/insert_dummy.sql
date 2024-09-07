-- Import CSV data into the cities table
COPY cities(city_id, city_name, latitude, longitude)
FROM '/Online Used Car Sales Database System/dummy_data/cities.csv'
DELIMITER ','
CSV HEADER;

-- Import CSV data into the users table
COPY users(user_id, name, contact, city_id)
FROM '/Online Used Car Sales Database System/dummy_data//users.csv'
DELIMITER ','
CSV HEADER;

-- Import CSV data into the cars table
COPY cars(product_id, brand, model, body_type, year, price, city_id, user_id, description)
FROM '/Online Used Car Sales Database System/dummy_data//cars.csv'
DELIMITER ','
CSV HEADER;

-- Import CSV data into the ads table
COPY ads(ad_id, title, product_id, user_id, allow_bid)
FROM '/Online Used Car Sales Database System/dummy_data//ads.csv'
DELIMITER ','
CSV HEADER;

-- Import CSV data into the bids table
COPY bids(bid_id, product_id, user_id, bid_price, bid_date)
FROM '/Online Used Car Sales Database System/dummy_data//bids.csv'
DELIMITER ','
CSV HEADER;