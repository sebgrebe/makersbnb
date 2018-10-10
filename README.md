### MakersBnb

Rent and offer rooms!

Chloe, Nazia, Seb and Vu are building an airbnb clone.

## MVP: User stories

```As a user, I can offer a room```  
```As a user, I can set availability of the room```  
```As a user, I can name my room, give a short description, and price per night```  

```As a user, I can see a list of all rooms```  
```As a user, I can see whether a room is available```  
```As a user, I can book a room if it is available```  
```As a user, I get a confirmation if I book a room```  

## Tech stack
* View: HTML/CSS/JS  
* interface.js: Makes calls to api  
* Backend API: Sinatra/Ruby  
* Database: Postgresql  

## Instructions: Run locally
* git clone this project
* run ```bundle install```
* Using postgresql, create a database with name 'MakersBnB' (to run the tests, you will also need 'MakersBnB_test').
* Create database using commands below
* Run ```rackup```
* App is hosted on http://localhost:9292

TO CREATE DATABASE

CREATE DATABASE makersbnb
\c makersbnb

CREATE TABLE users (
user_id SERIAL PRIMARY KEY,
email VARCHAR(355) UNIQUE NOT NULL,
password VARCHAR(240) NOT NULL,
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(20) NOT NULL);

CREATE TABLE rooms (
room_id SERIAL PRIMARY KEY,
room_name VARCHAR(20),
description VARCHAR (200),
price_per_night INTEGER,
available BOOLEAN,
location VARCHAR(50),
owner_user_id INTEGER REFERENCES users(user_id)
);

CREATE TABLE bookings (
booking_id SERIAL PRIMARY KEY,
room_id INTEGER REFERENCES rooms(room_id),
booker_user_id INTEGER REFERENCES users(user_id),
status VARCHAR (20)
);
