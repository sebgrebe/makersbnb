$(document).ready(function() {
  getOffers()

  $(document).on("click", ".booking-confirm", function(val) {
    var booking_id = val.currentTarget.id.substr(16)
    confirmOffer(booking_id)
  })

  $(document).on("click", ".booking-decline", function(val) {
    var booking_id = val.currentTarget.id.substr(16)
    declineOffer(booking_id)
  })
})

function getOffers() {
  $.ajax({
    url: 'http://localhost:9292/api/users/offers',
    type: 'GET',
    dataType: 'json'
  })
  .done(function(data) {
    if (data.success === true) {
      rooms = data.rooms
      console.log(rooms)
      rooms.forEach(function(room){
        $('.rooms').append(roomHTML(room));
      })
    } else {
      showError(data.msg)
    }
  })
  .fail(function(xhr,status,errorThrown) {
    alert("Sorry, there was a problem. Status: " + status)
  })
}

function confirmOffer(booking_id) {
  $.ajax({
    url: 'http://localhost:9292/api/users/offers/confirm?' + jQuery.param({booking_id: booking_id}),
    type: 'POST',
    dataType: 'json'
  })
  .done(function(data) {
    location.reload()
  })
  .fail(function(xhr,status,errorThrown) {
    alert("Sorry, there was a problem. Status: " + status)
  })
}

function declineOffer(booking_id) {
  $.ajax({
    url: 'http://localhost:9292/api/users/offers/decline?' + jQuery.param({booking_id: booking_id}),
    type: 'POST',
    dataType: 'json'
  })
  .done(function(data) {
    location.reload()
  })
  .fail(function(xhr,status,errorThrown) {
    alert("Sorry, there was a problem. Status: " + status)
  })
}

function roomHTML(room) {
  var room_div = "<div id='room-" + room.room_id + "' class='room'>"
  room_div += "<div class='room-name'>" + room.room_name + "</div>"
  room_div += "<div class ='room-desc'>" + room.description + "</div>"
  room_div += "<div class ='room-location'>" + room.location + "</div>"
  room_div += "<div class ='room-price'> Price per night: £" + room.price_per_night + "</div>"
  room_div += "<div class ='room-status'> Status: " + room.booking.status + "</div>"
  if (room.booking.status === 'Requested') {
    room_div += "<button id='booking-confirm-" + room.booking.booking_id + "' class='booking-confirm'> Confirm </button>"
    room_div += "<button id='booking-decline-" + room.booking.booking_id + "' class='booking-decline'> Decline </button>"
  }
  if (room.booking.status !== 'Not requested') {
    room_div += "<div class='room-booker' id='booking-confirm'>Booker: " + room.booking.booker_name + " </button>"
  }
  room_div += "</div>"
  return room_div
}

function formatAvailability(availability) {
  if(availability === 't') {
    return "Yes";
  } else {
    return "No";
  }
}

function showError(msg) {
  $('#messages').text('')
  $('#messages').append('<div class="error">' + msg + '</div>');
}
