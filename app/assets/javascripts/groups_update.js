$(function(){
  var group = $("#group").text();
  var user = $("#user").text();
  var user_name = $("#user_name").text();
  var groupHash = new Object();
  groupHash[user] = user_name;
  console.log(groupHash);
  $('#edit_group_'+group+' .button').click(function(event){
    event.preventDefault();

    var email= $('#group_users').val();
    $.ajax({
      type: "PUT",
      dataType: "json",
      url: ("/users/"+user+"/groups/"+group),
      data: {email: email}
    })
    .done(function( response ){
      $('#added_friends ul').append("<li><h4>"+response.user.first_name + " " + response.user.last_name+"</h4></li><p>"+response.user.email+"</p><hr>");
      groupHash[response.user.id] = response.user.first_name;
      response.group.forEach(function(object, index, group){
        $('.transactions-for-group').append("<li>"+groupHash[object.debtor_id]+ " owes  "+groupHash[object.creditor_id]+" - $"+object.amount+"</li>");
      $('#group_users').val("");
      });

    });


  });

  $('.marked-paid').parent().parent().parent().parent().parent().css({
    opacity: "0.5"
  });


});
