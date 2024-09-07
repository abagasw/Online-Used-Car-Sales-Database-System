-- 1. Ranking Popularitas Model Mobil Berdasarkan Jumlah Bid
SELECT
    cars.model,
    COUNT(ads.ad_id) AS bid_count
FROM
    ads
JOIN cars ON ads.product_id = cars.product_id
WHERE
    ads.allow_bid = true
GROUP BY
    cars.model
ORDER BY
    bid_count DESC;

-- 2. Membandingkan Harga Mobil Berdasarkan Harga Rata-rata per Kota
SELECT
    cities.city_name,
    AVG(cars.price) AS avg_price
FROM
    cars
JOIN cities ON cars.city_id = cities.city_id
GROUP BY
    cities.city_name
ORDER BY
    avg_price DESC;

-- 3. Cari Perbandingan Tanggal User Melakukan Bid dengan Bid Selanjutnya beserta Harga Tawar
WITH ranked_bids AS (
    SELECT
        product_id,
        user_id,
        bid_price,
        bid_date,
        LAG(bid_date) OVER (PARTITION BY product_id ORDER BY bid_date) AS prev_bid_date,
        LAG(bid_price) OVER (PARTITION BY product_id ORDER BY bid_date) AS prev_bid_price
    FROM
        bids
)
SELECT
    product_id,
    user_id,
    bid_date,
    prev_bid_date,
    bid_price,
    prev_bid_price
FROM
    ranked_bids
ORDER BY
    product_id, bid_date;

-- 4. Membandingkan Persentase Perbedaan Rata-rata Harga Mobil Berdasarkan Modelnya dan Rata-rata Harga Bid
WITH avg_price_model AS (
    SELECT
        model,
        AVG(price) AS avg_price
    FROM
        cars
    GROUP BY
        model
),
avg_bid_price_model AS (
    SELECT
        cars.model,
        AVG(bids.bid_price) AS avg_bid_6month
    FROM
        bids
    JOIN cars ON bids.product_id = cars.product_id
    WHERE
        bids.bid_date >= (CURRENT_DATE - interval '6 month')
    GROUP BY
        cars.model
)
SELECT
    avg_price_model.model,
    avg_price_model.avg_price,
    avg_bid_price_model.avg_bid_6month,
    (avg_bid_price_model.avg_bid_6month - avg_price_model.avg_price) AS difference,
    ((avg_bid_price_model.avg_bid_6month - avg_price_model.avg_price) / avg_price_model.avg_price) * 100 AS difference_percent
FROM
    avg_price_model
LEFT JOIN avg_bid_price_model ON avg_price_model.model = avg_bid_price_model.model;

-- 5. Membuat Window Function Rata-rata Harga Bid Sebuah Merk dan Model Mobil Selama 6 Bulan Terakhir
WITH filtered_bids AS (
    SELECT
        cars.brand,
        cars.model,
        bids.bid_price,
        bids.bid_date
    FROM
        bids
    JOIN cars ON bids.product_id = cars.product_id
    WHERE
        bids.bid_date >= (CURRENT_DATE - interval '6 month')
)
SELECT
    brand,
    model,
    bid_price,
    bid_date,
    AVG(bid_price) OVER (PARTITION BY brand, model ORDER BY bid_date RANGE BETWEEN INTERVAL '6 months' PRECEDING AND CURRENT ROW) AS avg_bid_price_6month
FROM
    filtered_bids;