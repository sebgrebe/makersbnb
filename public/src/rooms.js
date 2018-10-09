$(document).ready(function() {
  getRooms()

  $(document).on("click", ".booking-button", function(val) {
    var button_id = val.currentTarget.id
    var room_id = button_id.substr(15,button_id.length-1)
    //bookRoom(room_id)
    showBookingConfirmation('studioflat') //this needs to be deleted once ajax is working
  });

  $(document).on("click", ".booking-button-disabled", function() {
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
  $.ajax({
    url: 'http://localhost:9292/api/rooms',
    type: 'GET',
    dataType: 'json'
  })
  .done(function(data) {
    data.forEach(function(room){
      $('.rooms').append(roomHTML(room));
    })
  })
  .fail(function(xhr,status,errorThrown) {
    alert("Sorry, there was a problem. Status: " + status)
  })
}

function showBookingConfirmation(room_name){
  $('#messages').text('')
  $('#messages').append('<div class="confirmation">You have successfully booked the room: ' + room_name + '</div>');
}

function showBookingError() {
  $('#messages').text('')
  $('#messages').append('<div class="error">You cannot book unavailable rooms</div>');
}

function roomHTML(room) {
  var room_div = "<div id='room-" + room.room_id + "' class='room'>"
  room_div += "<div class='room-name'>" + room.name + "</div>"
  room_div += "<div class ='room-desc'>" + room.description + "</div>"
  room_div += "<div class ='room-location'>" + room.location + "</div>"
  room_div += "<div class ='room-price'> Price per night: £" + room.price_per_night + "</div>"
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
