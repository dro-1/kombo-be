# CREATE USER 'dro4'@'localhost' IDENTIFIED BY 'password';

# GRANT ALL PRIVILEGES ON *.* TO 'dro4'@'localhost';

CREATE DATABASE kombo;

USE kombo;

CREATE TABLE city (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name_fr VARCHAR(100) NOT NULL,
    name_it VARCHAR(100) NOT NULL,
    name_es VARCHAR(100) NOT NULL,
    name_en VARCHAR(100) NOT NULL,
    name_de VARCHAR(100) NOT NULL,
    name_nl VARCHAR(100) NOT NULL,
    name_pt VARCHAR(100) NOT NULL,
	location_lat DECIMAL(8,6) NOT NULL,
    location_lng DECIMAL(9,6) NOT NULL
);

CREATE INDEX name_fr_index ON city (name_fr);
CREATE INDEX name_it_index ON city (name_it);
CREATE INDEX name_es_index ON city (name_es);
CREATE INDEX name_en_index ON city (name_en);
CREATE INDEX name_de_index ON city (name_de);
CREATE INDEX name_nl_index ON city (name_nl);
CREATE INDEX name_pt_index ON city (name_pt);

# I used Decimals for the lat and lng as opposed to POINT because we wouldn't be calculating any distances between coordinates.

INSERT INTO city (name_fr, name_it, name_es, name_en, name_de, name_nl, name_pt, location_lat, location_lng) 
values ('Paris', 'Parigi', 'París', 'Paris','Paris', 'Parijs', 'Paris', 48.8566, -2.3522),
 ('Lisbonne', 'Lisbona', 'Lisboa', 'Lisbon', 'Lissabon', 'Lissabon', 'Lisboa', 38.7223, 9.1393),
 ('Denver', 'Denver', 'Denver', 'Denver', 'Denver', 'Denver', 'Denver', 39.7392, 104.9903),
 ('San Francisco', 'San Francisco', 'San Francisco', 'San Francisco', 'San Francisco', 'San Francisco', 'São Francisco', 37.7749, 122.4194),
 ('Berlin', 'Berlino', 'Berlina', 'Berlin', 'Berlin', 'Berlijn', 'Berlim', 52.5200, -13.4050),
 ('New York', 'New York', 'Nueva York', 'New York','New York', 'New York', 'Nova York', 40.7128, 74.0060),
 ('La Nouvelle Orléans', 'New Orleans', 'Nueva Orleans', 'New Orleans', 'New Orleans', 'New Orleans', 'Nova Orleans', 29.9511, 90.0715),
 ('Nouvelle-Angleterre', 'Nuova Inghilterra', 'Nueva Inglaterra', 'New England', 'Neu England', 'Nieuw Engeland', 'Nova Inglaterra', 43.9654, 70.8227),
 ('New Hampshire', 'New Hampshire', 'New Hampshire', 'New Hampshire', 'New Hampshire', 'New Hampshire', 'Nova Hampshire', 43.1939, 71.5724),
 ('Nouveau Mexique', 'Nuovo Messico', 'Nuevo Mexico', 'New Mexico', 'New-Mexiko', 'New Mexico', 'Novo México', 34.5199, 105.8701);

SELECT name_en, location_lat, location_lng FROM city;

CREATE TABLE train (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
    max_passengers INT NOT NULL,
    current_passengers INT DEFAULT 0
);

INSERT INTO train (name, max_passengers, current_passengers) 
values ('The Great Red', 1000, 267),
	('Over The Moon', 550, 500),
    ('Red Twist', 720, 0),
    ('The Clusterdust', 350, 342),
    ('The Milky Way', 1500, 943);
    
INSERT INTO train (name, max_passengers) 
values ('The Great Blue', 1000);
    
SELECT * FROM train;

CREATE TABLE customer(
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL
);

# I'm storing the password in plain text here although it would normally be hashed before it's inserted into the DB

INSERT INTO customer (first_name, last_name, email, password) 
values ('Harry', 'Maguire', 'maguire@gmail.com', 'justM@gu1re'),
	('Marcus', 'Rashford', 'rashy@gmail.com', 'c00lR@shy'),
    ('Jadon', 'Sancho', 'sanchee@gmail.com', 'j@d0Sanch0'),
    ('Crisitiano', 'Ronaldo', 'cr7@gmail.com', 'GO@Tcr7r0n@ld0'),
    ('Mason', 'Greenwood', 'mason@gmail.com', 'l@dM@s0n2!');

CREATE TABLE station (
	id INT AUTO_INCREMENT PRIMARY KEY,
	city_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
	FOREIGN KEY (city_id) REFERENCES city(id)
);

INSERT INTO station (city_id, name, address) 
values (1, 'Paris 1','3, Paris Street'),
	(2, 'Lisbon 2','2, Lisbon Street'),
    (3, 'Denver 1','10, Denver Street'),
    (4, 'San Francisco 1','9, San Francisco Way'),
    (5, 'Berlin 2','3, Berlin Street');
    
INSERT INTO station (city_id, name) 
VALUES	(1, 'Paris 2'),
    (2, 'Lisbon 1'),
    (5, 'Berlin 1'),
    (3, 'Denver 2'),
    (2, 'Lisbon 3'),
    (1, 'Paris 3'),
    (4, 'San Francisco 2');
	

SELECT * FROM station;

CREATE TABLE route (
	id INT AUTO_INCREMENT PRIMARY KEY,
	departure_station INT NOT NULL,
	arrival_station INT NOT NULL,
    train_id INT NOT NULL,
	departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    FOREIGN KEY (departure_station) REFERENCES station(id),
    FOREIGN KEY (arrival_station) REFERENCES station(id),
    FOREIGN KEY (train_id) REFERENCES train(id)
);

INSERT INTO route (departure_station, arrival_station, train_id, departure_time, arrival_time) 
VALUES	(1, 2, 2, '2021-11-24 01:15:00', '2021-11-24 01:45:00'),
    (1, 5, 2, '2021-11-24 01:05:00', '2021-11-24 02:00:00'),
	(11, 9, 1, '2021-11-24 12:15:00', '2021-11-24 17:45:00'),
    (12, 10, 5, '2021-11-24 19:10:00', '2021-11-24 22:45:00'),
    (6, 3, 4, '2021-11-24 16:15:00', '2021-11-24 18:45:00'),
    (5, 6, 2, '2021-11-24 05:00:00', '2021-11-24 06:15:00'),
    (4, 7, 3, '2021-11-24 11:45:00', '2021-11-24 16:10:00');
    
    SELECT * FROM route;

CREATE TABLE ticket (
	id INT AUTO_INCREMENT PRIMARY KEY,
	route_id INT NOT NULL,
	customer_id INT NOT NULL,
	price DECIMAL(8,2) NOT NULL,
    FOREIGN KEY (route_id) REFERENCES route(id),
    FOREIGN KEY (customer_id) REFERENCES customer(id)
);

INSERT INTO ticket (route_id, customer_id, price) 
VALUES	(1, 2, 2534.76),
    (1, 5, 2534.76),
    (2, 2, 3555.21),
    (4, 5, 1034.26),
    (7, 4, 434.03),
    (6, 3, 435.94),
    (3, 1, 893.20),
    (5, 5, 394.39),
    (6, 2, 125.78),
    (7, 4, 483.09);
    
    SELECT * FROM ticket;
    
    
    USE kombo;
        SELECT * FROM city;
    SELECT * FROM city WHERE `name_en` LIKE 'L%';







