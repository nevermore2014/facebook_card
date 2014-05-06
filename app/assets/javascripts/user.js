var FacebookCard = FacebookCard || {};

FacebookCard.buildHomepage = function(){
  var $cardZone = $('.cardZone');

  $cardZone.text("");

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
  var $cardZone = $('.cardZone'),
      $insertCard = $('<div class="insertCard">'),
      $info_div = $('<div class="col-md-7 info">'),
      $img_div = $('<div class="col-md-1 img">'),
      $count_div = $('<div class="count">'),

      $name = $('<h3>' + callback.name + '</h3>'),
      $location = $('<p>' + callback.location + '</p>'),
      $img = $('<img id="img" src=' + callback.img_url + '>'),
      $count = $('<p>likes:' + callback.num_like + ' comments:' + callback.num_comment + '  photos:' + callback.num_photo + '  status:' + callback.num_status + ' links:' + callback.num_link + '  videos:' + callback.num_video + '</p>'),
      $basic_div = $('<div class="basic">');

  $cardZone.text("");
  $info_div.append($name, $location);
  $img_div.append($img);
  $basic_div.append($img_div, $info_div);
  $count_div.append($count);
  $insertCard.append($basic_div, $count_div);
  $cardZone.append($insertCard);


};