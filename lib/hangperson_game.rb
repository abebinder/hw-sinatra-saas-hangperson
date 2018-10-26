class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  attr_accessor :word, :guesses, :wrong_guesses

  def guess(letter)
    raise ArgumentError unless letter.instance_of?(String) && letter.match(/\A[a-zA-z]\z/)
    letter.downcase!
    return false if @guesses.include?(letter) || @wrong_guesses.include?(letter)
    (@word.include? letter) ? @guesses.concat(letter) : @wrong_guesses.concat(letter)
    true
  end
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
