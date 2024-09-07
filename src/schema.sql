CREATE TABLE "cities" (
  "city_id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "city_name" varchar(50),
  "latitude" float,
  "longitude" float
);

CREATE TABLE "users" (
  "user_id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" varchar(100),
  "contact" varchar(20),
  "city_id" int
);

CREATE TABLE "cars" (
  "product_id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "brand" varchar(50),
  "model" varchar(50),
  "body_type" varchar(50),
  "year" int,
  "price" decimal(12,2),
  "city_id" int,
  "user_id" int,
  "description" text
);

CREATE TABLE "ads" (
  "ad_id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "title" varchar(100),
  "product_id" int,
  "user_id" int,
  "allow_bid" boolean
);

CREATE TABLE "bids" (
  "bid_id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "product_id" int,
  "user_id" int,
  "bid_price" decimal(12,2),
  "bid_date" timestamp
);

ALTER TABLE "users" ADD FOREIGN KEY ("city_id") REFERENCES "cities" ("city_id");

ALTER TABLE "cars" ADD FOREIGN KEY ("city_id") REFERENCES "cities" ("city_id");

ALTER TABLE "cars" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "ads" ADD FOREIGN KEY ("product_id") REFERENCES "cars" ("product_id");

ALTER TABLE "ads" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "bids" ADD FOREIGN KEY ("product_id") REFERENCES "cars" ("product_id");

ALTER TABLE "bids" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");
