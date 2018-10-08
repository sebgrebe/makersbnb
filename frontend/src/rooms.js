//mock response while database is not workig.
var data_mock = [{
  id: 1,
  name: 'Room 1',
  description: 'Description of Room1',
  location: 'North',
  price: 10,
  available: true,
  owner: 'Owner Room1'
},{
  id: 2,
  name: 'Room 2',
  description: 'Description of Room2',
  location: 'South',
  price: 15,
  available: false,
  owner: 'Owner Room2'
},{
  id: 3,
  name: 'Room 3',
  description: 'Description of Room1',
  location: 'West',
  price: 10,
  available: true,
  owner: 'Owner Room3'
}]
//JSON stringify as that's how it comes back from API
data_mock_json = JSON.stringify(data_mock)

$(document).ready(function() {
  var rooms = getRooms();
  rooms.forEach(function(room){
    $('.rooms').append(roomHTML(room));
  })
})

function formatAvailability(availability) {
  if(availability === true) {
    return "Yes";
  } else {
    return "No";
  }
}

function getRooms() {
  // uncomment when database API is working
  // $.ajax({
  //   url: 'http://localhost:9292/api/rooms',
  //   type: 'GET',
  //   dataType: 'json'
  // })
  // .done(function(data) {
  //  data = JSON.parse(data_mock_json);
  //  return data;
  // })
  // .fail(function(xhr,status,errorThrown) {
  //   alert("Sorry, there was a problem. Status: " + status)
  // })
  data = JSON.parse(data_mock_json);
  return data;
}

function roomHTML(room) {
  var room_div = "<div id='room-" + room.id + "' class='room'>"
  room_div += "<p class='room-name'>" + room.name + "</p>"
  room_div += "<p class ='room-desc'>" + room.description + "</p>"
  room_div += "<p class ='room-location'>" + room.location + "</p>"
  room_div += "<p class ='room-price'> Price per night: £" + room.price + "</p>"
  room_div += "<p class ='room-available'> Available: " + formatAvailability(room.available) + "</p>"
  room_div += "<p class ='room-owner'> Owner: " + room.owner + "</p>"
  room_div += "</div>"
  return room_div
}
