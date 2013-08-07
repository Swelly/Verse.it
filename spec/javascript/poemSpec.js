describe ("createUserDisplay", function() {

  it("should create the desired DOM element", function() {
    var user = {
      profile_image_url: "http://www.example.com",
      screen_name: "alice",
      name: "Alice M.",
      description: "I am a human bean",
      status: { text: "It's raining." }
    };

    var element = createUserDisplay(1, user);
    var targetString = '<div id="1"><img src="http://www.example.com"><span class="handle"><a href="http://www.twitter.com/alice">alice</span><br>Alice M.<br>I am a human bean.<br>It\'s raining.</div>';

    expect(element).toEqual(targetString);

  });

});