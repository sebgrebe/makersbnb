$(document).ready(function(){
  $('#signup-btn').click(function(){
    var signup = {
      first_name: $('#first_name').val(),
      last_name: $('#last_name').val(),
      email: $('#email').val(),
      password: $('#password').val(),
    }
    callSignUp(signup)
  })

});

function callSignUp(signup) {
   $.ajax({
    url: 'http://localhost:9292/api/signup?'+ jQuery.param({signup: signup}),
    type: 'POST',
    dataType: 'json',
  })
  .done(function(data) {
    if (data.success) {
      document.cookie = "first_name=" + data.user.first_name + ",user_id=" + data.user.user_id
      showSuccess(data.user.first_name)
    } else {
      showError(data.msg)
    }
  })
  .fail(function(xhr,status,errorThrown) {
    showError('Sorry, something went wrong' )
  })
}

function showError(msg) {
  $('#messages').text('')
  $('#messages').append('<div class="error">' + msg + '</div>');
}

function showSuccess(name){
  $('#messages').text('')
  $('#messages').append('<div class="confirmation"> Hello ' + name + '. Signup was successful.</div>');
}
