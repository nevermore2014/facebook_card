var FacebookCard = FacebookCard || {};

FacebookCard.buildHomepage = function(){
};

FacebookCard.drawCard = function(user_id){
  $.ajax({
    url: '/user/'+ user_id,
    type: 'GET',
    dataType: 'json',
  })
  .done(function() {
    console.log("success");
  })
  .fail(function() {
    console.log("error");
  })
  .always(function() {
    console.log("complete");
  });
  
};