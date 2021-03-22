--PostgreSQL
CREATE DATABASE retail
    WITH 
    OWNER = "postgres-user"
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;
	


CREATE TABLE customers (id INT PRIMARY KEY, name VARCHAR(255) NOT NULL);

CREATE TABLE orders (id INT PRIMARY KEY, product INT, quantity INT, customer_id INT NOT NULL);

--ksqldb
CREATE SOURCE CONNECTOR retail_reader WITH (
    'connector.class' = 'io.debezium.connector.postgresql.PostgresConnector',
    'database.hostname' = 'postgres',
    'database.port' = '5432',
    'database.user' = 'postgres-user',
    'database.password' = 'postgres-pw',
    'database.dbname' = 'retail',
    'database.server.name' = 'retail',
    'table.whitelist' = 'public.customers,public.orders',
    'transforms' = 'unwrap',
    'transforms.unwrap.type' = 'io.debezium.transforms.ExtractNewRecordState',
    'transforms.unwrap.drop.tombstones' = 'false',
    'transforms.unwrap.delete.handling.mode' = 'rewrite'
);

INSERT INTO customers (id, name) VALUES (-1, 'test');
INSERT INTO orders (id, product, quantity, customer_id) VALUES (-1, -100, 0, -2);

CREATE STREAM stream_customers WITH (KAFKA_TOPIC='retail.public.customers', value_format='avro');

CREATE STREAM stream_customers_json 
WITH (KAFKA_TOPIC='stream_customers_json', VALUE_FORMAT='json') 
AS SELECT * FROM stream_customers;

CREATE STREAM stream_orders WITH (KAFKA_TOPIC='retail.public.orders', value_format='avro');

CREATE STREAM stream_orders_json 
WITH (KAFKA_TOPIC='stream_orders_json', VALUE_FORMAT='json') 
AS SELECT * FROM stream_orders;

-----------------------------------------
--PostgreSQL
INSERT INTO customers (id,name) VALUES (6,'Alexander'),(7,'Lawrence'),(8,'Andrew'),(9,'Honorato'),(10,'Darius');

INSERT INTO orders (id,product,quantity,customer_id) VALUES (1,10,5062,10),(2,4,5376,8),(3,7,5340,10),(4,10,5567,10),(5,5,5383,10),(6,3,5493,9),(7,5,5271,10),(8,1,5696,9),(9,2,5740,9),(10,10,5577,10),(11,1,5762,7),(12,7,5708,7),(13,6,5468,10),(14,1,5494,7),(15,2,5627,9),(16,4,5691,9),(17,3,5969,8),(18,2,5546,6),(19,6,5575,7),(20,4,5036,8),(21,8,5786,8),(22,4,5186,7),(23,4,5606,9),(24,5,5814,7),(25,6,5470,9),(26,10,5219,9),(27,1,5920,7),(28,5,5819,8),(29,7,5182,8),(30,7,5219,6),(31,3,5271,7),(32,5,5675,8),(33,9,5429,6),(34,7,5823,6),(35,7,5969,6),(36,2,5008,9),(37,9,5932,10),(38,4,5817,6),(39,6,5663,8),(40,7,5307,10),(41,4,5168,6),(42,3,5008,7),(43,3,5416,10),(44,3,5471,6),(45,6,5986,10),(46,6,5605,10),(47,6,5026,8),(48,1,5140,9),(49,10,5973,7),(50,9,5506,7),(51,6,5143,9),(52,7,5016,8),(53,5,5234,8),(54,7,5559,9),(55,7,5275,9),(56,5,5414,8),(57,5,5932,10),(58,7,5694,9),(59,9,5961,8),(60,3,5511,10),(61,8,5164,8),(62,5,5646,8),(63,8,5039,7),(64,10,5545,7),(65,5,5922,9),(66,1,5592,7),(67,5,5658,9),(68,5,5054,9),(69,7,5553,10),(70,6,5946,9),(71,4,5660,9),(72,1,5136,6),(73,10,5003,9),(74,7,5619,7),(75,1,5801,9),(76,2,5105,9),(77,2,5825,10),(78,3,5668,8),(79,6,5778,6),(80,2,5879,8),(81,1,5113,9),(82,10,5636,10),(83,9,5847,9),(84,7,5463,8),(85,5,5141,7),(86,7,5624,9),(87,9,5544,6),(88,10,5036,9),(89,8,5414,9),(90,1,5763,9),(91,7,5960,6),(92,3,5535,7),(93,10,5193,7),(94,9,5957,9),(95,1,5555,6),(96,4,5821,9),(97,10,5617,9),(98,10,5777,8),(99,4,5069,7),(100,1,5032,9);



