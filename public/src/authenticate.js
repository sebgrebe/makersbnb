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

  $('#login-btn').click(function(){
    var login = {
      email: $('#email').val(),
      password: $('#password').val(),
    }
    callLogin(login)
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
      window.location.replace("/user")
    } else {
      showError(data.msg)
    }
  })
  .fail(function(xhr,status,errorThrown) {
    showError('Sorry, something went wrong' )
  })
}

function callLogin(login) {
   $.ajax({
    url: 'http://localhost:9292/api/login?'+ jQuery.param({login: login}),
    type: 'POST',
    dataType: 'json',
  })
  .done(function(data) {
    if (data.success) {
      window.location.replace("/user")
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
