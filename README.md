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
* Create a table 'rooms', using "CREATE TABLE rooms (room_id SERIAL PRIMARY KEY, name VARCHAR(20),description VARCHAR(200), price_per_night INTEGER, available BOOLEAN, owner VARCHAR(20), location VARCHAR(50));"
* Run ```rackup```
* App is hosted on http://localhost:9292
