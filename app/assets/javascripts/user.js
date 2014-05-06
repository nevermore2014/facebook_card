var FacebookCard = FacebookCard || {};

FacebookCard.buildHomepage = function(){

};

FacebookCard.getCardData = function(user_id){
  $.ajax({
    url: '/users/' + user_id + '/cards/1',
    type: 'GET',
    dataType: 'json',
    data: { id: user_id },
  })
  .done(function(data) {
    FacebookCard.drawCard(data);
  })
  .fail(function() {
    console.log("error");
  })
  .always(function() {
    console.log("complete");
  });
};

FacebookCard.drawCard = function(callback){
  
};