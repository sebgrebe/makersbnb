//mock response while database is not workig.
var data_mock = [{
  name: 'Room 1',
  description: 'Description of Room1',
  price: 10,
  available: true,
  owner: 'Owner Room1'
},{
  name: 'Room 2',
  description: 'Description of Room2',
  price: 15,
  available: false,
  owner: 'Owner Room2'
},{
  name: 'Room 3',
  description: 'Description of Room1',
  price: 10,
  available: true,
  owner: 'Owner Room1'
}]
//JSON stringify as that's how it comes back from API
data_mock_json = JSON.stringify(data_mock)

$(document).ready(function() {
  $.ajax({
    url: 'http://localhost:9292/api/rooms',
    type: 'GET',
    dataType: 'json'
  })
  .done(function(data) {
    console.log(data)
  })
  .fail(function(xhr,status,errorThrown) {
    //put into .done when API is working
    data = JSON.parse(data_mock_json);
    console.log(data);

    // alert("Sorry, there was a problem. Status: " + status) //uncomment when API is working
  })
})
