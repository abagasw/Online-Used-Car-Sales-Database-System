-- 1. Mencari mobil keluaran 2015 ke atas
SELECT * FROM cars
WHERE year >= 2015;

-- 2. Menambahkan satu data bid produk baru
-- Misalnya, memasukkan data bid untuk produk dengan product_id = 1 dan user_id = 1
INSERT INTO ads (title, product_id, user_id, allow_bid)
VALUES ('Bid Baru untuk Product 1', 1, 1, true);

-- 3. Melihat semua mobil yang dijual oleh satu akun (misalnya user_id = 1) dari yang paling baru
SELECT * FROM cars
WHERE user_id = 1
ORDER BY year DESC;

-- 4. Mencari mobil bekas yang termurah berdasarkan keyword (misalnya "Toyota")
SELECT * FROM cars
WHERE brand ILIKE '%Toyota%'
ORDER BY price ASC
LIMIT 1;

-- 5. Mencari mobil bekas yang terdekat berdasarkan sebuah id kota
-- Misalnya city_id = 1 (Jakarta), menghitung jarak dari lokasi tersebut
WITH reference_city AS (
    SELECT latitude, longitude
    FROM cities
    WHERE city_id = 1
)
SELECT c.*, sqrt(
    POWER(cities.latitude - ref.latitude, 2) +
    POWER(cities.longitude - ref.longitude, 2)
) AS distance
FROM cars c
JOIN cities ON c.city_id = cities.city_id
CROSS JOIN reference_city ref
ORDER BY distance ASC
LIMIT 1;
