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
      $('#added_friends ul').append("<li>"+response.user.first_name+"</li>");
      response.group.forEach(function(object, index, group){
        // $('.transactions-for-group').
        $('.transactions-for-group').append("<li>"+object.amount+"</li>");
      });

    });


  });


});
