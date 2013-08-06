/////////////////////////
// SOURCE USER SELECTION
/////////////////////////

var currUserIndex = 0;
var userDivs = [];
var box;

// XXX
// I have two potential iteration variables, div id or global variable, which is better?

var createUserDisplay = function(divID, user) {
  var userDisplay = $('<div></div>');
  userDisplay.append('<img src="' + user.profile_image_url + '"><br>');
  userDisplay.append('<span id="handle"><a href="http://www.twitter.com/' + user.screen_name +'">' + user.screen_name + '</a></span><br>');
  userDisplay.append(user.name + '<br>');
  userDisplay.append(user.description + '<br>');
  userDisplay.append(user.status.text);
  userDisplay.attr('id', divID);
  return userDisplay;
};

$(function() {

  box = $('#user-select');

  $.ajax({
    url: '/poems/select_user',
    dataType: 'json',
    type: 'GET'
  }).done(function(data) { //handle the json response
    console.log(data);

    $(data).each(function(index, user) { userDivs.push(createUserDisplay(index, user)); });
    box.html(userDivs[currUserIndex]);
  });

  $('#left-arrow').click(scrollLeft);
  $('#right-arrow').click(scrollRight);
  $('#user-select-button').click(initiatePoemCreation)

});

var scrollLeft = function() {
  console.log('clicked');
  if (currUserIndex !== 0) {
    currUserIndex -= 1;
    box.html($(userDivs[currUserIndex]));
  }
};

var scrollRight = function() {
  console.log('r');
  if (currUserIndex < userDivs.length - 1) {
    currUserIndex += 1;
    box.html($(userDivs[currUserIndex]));
  }
};

var initiatePoemCreation = function() {
  $.ajax({
    type: 'POST',
    url: '/poems/new',
    dataType: 'json',
    data: $('#handle').innerText
  }).done(function(data) {
    // returned data = { user: user info, tweets: array of last 30 tweets }
    // use the returned data to generate the poem creation view

  });
};

/////////////////////////
// POEM CREATION
/////////////////////////





