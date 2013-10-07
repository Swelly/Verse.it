module OmniAuth::Strategies

  class TwitterWithPoem < Twitter
    def name
      :twitter_with_poem
    end
  end

  class TwitterLogin < Twitter
    def name
      :twitter_login
    end
  end


end