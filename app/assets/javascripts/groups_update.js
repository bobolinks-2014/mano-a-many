$(function(){
  $('#edit_group_41 .button').click(function(event){
    event.preventDefault();
    var group = $("#group").text();
    var user = $("#user").text();
    var email= $('#group_users').val();
    $.ajax({
      type: "PUT",
      data: {email: email},
      url: "/users/"+user+"/groups/"+group
    })
    .done(function( response ){
      console.log(response.first_name)
      $('#added_friends ul').append("<li>"+response.first_name+"</li>");
    });
  });



});
