$(function(){
  var group = $("#group").text();

  $('#edit_group_'+group+' .button').click(function(event){
    event.preventDefault();
    var user = $("#user").text();
    var email= $('#group_users').val();
    $.ajax({
      type: "PUT",
      dataType: "json",
      url: ("/users/"+user+"/groups/"+group),
      data: {email: email}
    })
    .done(function( response ){
      console.log(response.first_name)
      $('#added_friends ul').append("<li>"+response.first_name+"</li>");
    });


  });


});
