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
  description: 'Description of Room3',
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

  $( ".booking-button" ).click(function(val) {
    var button_id = val.currentTarget.id
    var room_id = button_id.substr(15,button_id.length-1)
    //bookRoom(room_id)
    showBookingConfirmation('studioflat') //this needs to be deleted once ajax is working
  });

  $( ".booking-button-disabled" ).click(function() {
    console.log('disabled')
    showBookingError()
  })
})

function bookRoom(room_id){
   $.ajax({
    url: 'http://localhost:9292/api/bookroom',
    type: 'POST',
    dataType: 'json',
    body: {room_id: room_id}

  })
  .done(function(data) {
    // implement logic for checking the response.
  })
  .fail(function(xhr,status,errorThrown) {
    alert("Sorry, there was a problem. Status: " + status)
  })

}

function formatAvailability(availability) {
  if(availability === true) {
    return "Yes";
  } else {
    return "No";
  }
}

function getRooms() {
  // TODO: uncomment when database API is working
  // $.ajax({
  //   url: 'http://localhost:9292/api/rooms',
  //   type: 'GET',
  //   dataType: 'json'
  // })
  // .done(function(data) {
  //   console.log(data)
  //  // data = JSON.parse(data_mock_json);
  //  // return data;
  // })
  // .fail(function(xhr,status,errorThrown) {
  //   alert("Sorry, there was a problem. Status: " + status)
  // })
  data = JSON.parse(data_mock_json);
  return data;
}

function showBookingConfirmation(room_name){
  $('#messages').text('')
  $('#messages').append('<div class="booking-confirmation">You have successfully booked the room: ' + room_name + '</div>');
}

function showBookingError() {
  $('#messages').text('')
  $('#messages').append('<div class="booking-error">You cannot book unavailable rooms</div>');
}

function roomHTML(room) {
  var room_div = "<div id='room-" + room.id + "' class='room'>"
  room_div += "<div class='room-name'>" + room.name + "</div>"
  room_div += "<div class ='room-desc'>" + room.description + "</div>"
  room_div += "<div class ='room-location'>" + room.location + "</div>"
  room_div += "<div class ='room-price'> Price per night: £" + room.price + "</div>"
  room_div += "<div class ='room-available'> Available: " + formatAvailability(room.available) + "</div>"
  room_div += "<div class ='room-owner'> Owner: " + room.owner + "</div>"
  room_div += bookingButtonHTML(room.id,room.available)
  room_div += "</div>"
  return room_div
}

function bookingButtonHTML(id,availability) {
  var booking_button_div = ''
  if (availability) { booking_button_div = "<button id='booking-button-" + id + "' class='booking-button'> Book </button>" }
  else { booking_button_div = "<button class='booking-button-disabled'> Book </button>" }
  return booking_button_div
}
