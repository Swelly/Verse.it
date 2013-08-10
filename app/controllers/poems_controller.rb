require Rails.root.join('lib', 'assets', 'wordTrie.rb')

class PoemsController < ApplicationController

  # GET
  # shows some recent or popular poems?
  def index
    @poems = Poem.order("created_at DESC")[0..29]
  end

  # GET
  # shows a single poem and its metadata
  def show
    @poem = Poem.find(params[:id])
  end

  def new
  end

  # GET
  # shows the form for selecting a user
  def select_user
    # @users = ['ichthala', 'wescarr17', 'seraphicmanta', 'tcclevela', 'antonwheel', 'horse_ebooks', 'catlandbooks']
    # @users.each_with_index do |user, index|
    #   @users[index] = Twitter.user(user)
    # end

    @users = []

    while @users.count < 9
      offset = rand(Twitteruser.count)
      rand_sn = Twitteruser.first(:offset => offset).screen_name
      unless @users.find_index(rand_sn)
        @users << rand_sn
      end
    end

    @users << 'horse_ebooks'

    @users.each_with_index do |user, index|
      @users[index] = Twitter.user(user)
    end

    respond_to do |format|
      format.html
      format.json {render json: @users}
    end

  end

  # POST (quirk for our app, POST posts the source user name)
  # shows the two-panel poem creation page
  def write_poem
    handle = params[:handle]

    # query Twitter API to get source user's last 30 tweets
    # XXX
    begin
      @tweets = Twitter.user_timeline(handle, count: 30)
    rescue Twitter::Error::TooManyRequests
      puts "Twitter API Rate Limit Exceeded"
      @tweets = {}
    end
    # respond with JSON for user info + his last 30 tweets
    respond_to do |format|
      format.json { render json: @tweets }
    end
  end

  # POST
  # adds the poem to the database and redirects to show
  def create
    @poem = Poem.create()

    @poem.text = params[:text]
    source_user = params[:source_user]
    @poem.source_user = source_user.slice(1, source_user.length - 1)
    @poem.user = current_user

    if @poem.save

      # update the user's word_count
      current_user.word_count += @poem.text.split.size

      # then check for titles
      @titles = check_for_titles(@poem)
      @titles.each do |title|
        current_user.titles << title
      end

      token = current_user.twitter_oauth_token #||= ENV['YOUR_OAUTH_TOKEN']
      secret = current_user.twitter_oauth_secret #||= ENV['YOUR_OAUTH_TOKEN_SECRET']

      # time to tweet the poem!
      client = Twitter::Client.new(
        consumer_key: ENV['YOUR_CONSUMER_KEY'],
        consumer_secret: ENV['YOUR_CONSUMER_SECRET'],
        oauth_token: token,
        oauth_token_secret: secret
      )

      tweet_text = '#vrsit '
      tweet_text += params[:source_user] + ' '
      tweet_text += @poem.text.truncate(90) + ' '
      tweet_text += 'verse.it/poems/' + @poem.id.to_s
      client.update(tweet_text)

    else
      # XXX
      # What to do if the poem doesn't save?
    end

    respond_to do |format|
      format.js {}
    end

  end

  # GET
  # we probably don't need this
  def edit
  end

  # PUT
  # don't need this either
  def update
  end

  # DELETE
  # deletes a poem, redirects to user profile?
  def destroy
  end

  #####################################
  ### TITLES
  #####################################

  def check_for_titles(aPoem)

    received_titles = []

    user_titles = []
    current_user.titles.each do |title|
      user_titles << title.title
    end

    # XXX
    # I would love to DRY up this code by just iterating
    # through the titles, but each title needs to be
    # associated with its function. What to do?
    # Can I use blocks?

    # Apprentice Wordsmith
    unless user_titles.include?("Apprentice Wordsmith")
      if title_first_post
        received_titles << Title.where(title: "Apprentice Wordsmith").first
      end
    end

    # Lord Tennyson
    unless user_titles.include?("Lord Tennyson")
      if title_tennyson
        received_titles << Title.where(title: "Lord Tennyson").first
      end
    end

    # Let Us Go Through Certain Half-Deserted Tweets
    unless user_titles.include?("Let Us Go Through Certain Half-Deserted Tweets")
      if title_let_us(aPoem.text)
        received_titles << Title.where(title: "Let Us Go Through Certain Half-Deserted Tweets").first
      end
    end

    # Wordsworthy
    unless user_titles.include?("Wordsworthy")
      if title_wordsworthy
        received_titles << Title.where(title: "Wordsworthy").first
      end
    end

    # Charge of the Tweet Brigade
    unless user_titles.include?("Charge of the Tweet Brigade")
      if title_tweet_brigade
        received_titles << Title.where(title: "Charge of the Tweet Brigade").first
      end
    end

    # Byronic Hero
    unless user_titles.include?("Byronic Hero")
      if title_byronic(aPoem.text)
        received_titles << Title.where(title: "Byronic Hero").first
      end
    end

    # # John Tweets
    # unless user_titles.include?("John Tweets")
    #   if title_john_tweets(aPoem.text)
    #     received_titles << Title.where(title: "John Tweets").first
    #   end
    # end

    # Poe-Trie
    unless user_titles.include?("Poe-Trie")
      if title_poe(aPoem.text)
        received_titles << Title.where(title: "Poe-Trie").first
      end
    end

    # Lovecraftian
    unless user_titles.include?("Lovecraftian")
      if title_lovecraftian(aPoem.text)
        received_titles << Title.where(title: "Lovecraftian").first
      end
    end

    # Duke of Repartee
    unless user_titles.include?("Duke of Repartee")
      if title_repartee(aPoem.source_user)
        received_titles << Title.where(title: "Duke of Repartee").first
      end
    end

    return received_titles
  end # end of check_for_titles


  ##### Title check functions
  def title_first_post
    return current_user.poems.count == 1
  end

  def title_tennyson
    return current_user.poems.count == 10
  end

  def title_let_us(poem_text)
    return poem_text.length <= 70
  end

  def title_wordsworthy
    return current_user.word_count >= 100
  end

  def title_tweet_brigade
    return current_user.word_count >= 600
  end

  def title_byronic(poem_text)
    words = poem_text.downcase.gsub(/[^a-z\s]/, '').split

    byronic_words = ['byronic',
      'brooding',
      'moody',
      'sorrow',
      'tempestuous',
      'moors',
      'stormy',
      'tortured',
      'loss',
      'angst',
      'vampire',
      'heathcliff',
      'sorrowful',
      'wistful',
      'longing',
      'pining',
      'suffering',
      'depression',
      'depressed',
      'sad',
      'sadness',
      'agony',
      'bipolar'
    ]

    words.each do |word|
      if byronic_words.include?(word)
        return true
      end
    end

    return false
  end

  def title_poe(poem_text)
    yaml_string = File.read(File.join(Rails.root, 'poe_trie.txt'))
    poe_trie = YAML::load(yaml_string)

    words = poem_text.downcase.gsub(/[^a-z\s]/, '').split

    words.each_with_index do |word, i|
      # binding.pry
      seq = "#{word} #{words[i+1]} #{words[i+2]}"
      if poe_trie.find(seq)
        return true
      end
    end
    return false
  end

  def title_lovecraftian(poem_text)
    words = poem_text.downcase.gsub(/[^a-z\s]/, '').split

    lovecraft_words = ['lovecraft',
      'yogsothoth',
      'shoggoth',
      'shubniggurath',
      'cthulhu',
      'rlyeh',
      'kadath',
      'ulthar',
      'azathoth',
      'celephais',
      'nyarlathotep',
      'necronomicon',
      'alhazred',
      'fhtagn',
      'arkham',
      'dunwich',
      'miskatonic',
      'leng',
      'eldritch',
      'noneuclidean',
      'innsmouth',
      'tsathoggua',
      'dagon',
      'tekelili'
    ]

    words.each do |word|
      if lovecraft_words.include?(word)
        return true
      end
    end

    return false

  end

  def title_repartee(source_user)
    other_user = User.where(twitter_handle: source_user).first
    if !other_user.blank? && other_user != current_user
      return !(other_user.poems.where(source_user: current_user.twitter_handle).blank?)
    end
    false
  end

end
