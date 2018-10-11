$(document).ready(function() {
  getRooms()


})

function bookRoom(room_id){
   $.ajax({
    url: 'http://localhost:9292/api/book_room?' + jQuery.param({id: room_id}),
    type: 'POST',
    dataType: 'json',
  })
  .done(function(data) {
    console.log(data)
    if (data.success) { showBookingConfirmation(data.room[0]['room_name'])
      changeAvailability(data.room[0]['room_id']);
  }
    else{ showBookingError();}
  })
  .fail(function(xhr,status,errorThrown) {
    alert("Sorry, there was a problem. Status: " + status)
  })
}

function formatAvailability(availability) {
  if(availability === 't') {
    return "Yes";
  } else {
    return "No";
  }
}

function getRooms() {
  $.ajax({
    url: 'http://localhost:9292/api/users/bookings',
    type: 'GET',
    dataType: 'json'
  })
  .done(function(data) {
    console.log(data)
    data.forEach(function(elem) {
      console.log(elem)
      if ('room_name' in elem) {
        console.log(elem['room_id']);
        $('.rooms').append(roomHTML(elem));
      }
      else {
        $('#room-' + elem.room_id + '').append(statusHTML(elem));
      }
    })
    // data.forEach(function(room){
    //   $('.rooms').append(roomHTML(room));

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

function changeAvailability(room_id){
  $('.room-available'+room_id).text('Available: ' + formatAvailability('f'));
}

function roomHTML(room) {
  var room_div = "<div id='room-" + room.room_id + "' class='room'>"
  room_div += "<div class='room-name'>" + room.room_name + "</div>"
  room_div += "<div class ='room-desc'>" + room.description + "</div>"
  room_div += "<div class ='room-location'>" + room.location + "</div>"
  room_div += "<div class ='room-price'> Price per night: £" + room.price_per_night + "</div>"
  room_div += "<div class ='room-available" + room.room_id + "'> Available: " + formatAvailability(room.available) + "</div>"
  room_div += "<div class ='room-owner'> Owner: " + room.owner_user_id + "</div>"
  room_div += "</div>"
  room_div += "<div id='room-" + room.room_id + "' class='room-status-" + room.room_id + "'>" + "</div>"
  return room_div
}
function statusHTML(room) {
  var status_div =  "Status: " + room.status
  return status_div
}
function bookingButtonHTML(id,availability) {
  var booking_button_div = ''
  if (availability) { booking_button_div = "<button id='booking-button-" + id + "' class='booking-button'> Book </button>" }
  else { booking_button_div = "<button class='booking-button-disabled'> Book </button>" }
  return booking_button_div
}
