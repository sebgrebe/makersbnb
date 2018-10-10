$(document).ready(function(){
  $('#offer-btn').click(function(){
    //TODO: Replace user_id with actual one
    var offer = {
      name: $('#name').val(),
      description: $('#description').val(),
      price: $('#price').val(),
      available: $('#available_yes').is(':checked'),
      location: $('#location').val(),
    }

    //offerRoom(offer);
    if (validateInput(offer)) {
      offerRoom(offer)
    };

  })
})

function validateInput(offer){
  var missing = false
  Object.keys(offer).forEach(function(key){
    if (offer[key] === NaN || offer[key] === '') { missing = true }
  })
  if (missing) {
    showError('Please provide input for each field.')
    return false
  } else {
    return true
  }
  // use for proper validation of all text input
  // result = /^[A-Za-z\s]+$/.test(offer.name)
}

function offerRoom(offer){
   $.ajax({
    url: 'http://localhost:9292/api/offer_room?'+ jQuery.param({offer: offer}),
    type: 'POST',
    dataType: 'json',
  })
  .done(function(data) {
    // implement logic for checking the response.
    // if successful, give confirmation
    if (data === 'success') { showOfferConfirmation() }
    else { showError('Sorry, something went wrong') }
  })
  .fail(function(xhr,status,errorThrown) {
    showError('Sorry, something went wrong' )
  })
}

function showOfferConfirmation(){
  $('#messages').text('')
  $('#messages').append('<div class="confirmation">Your room has been offered.</div>');
}

function showError(msg) {
  $('#messages').text('')
  $('#messages').append('<div class="error">' + msg + '</div>');
}
