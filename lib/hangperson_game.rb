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
    @word_with_guesses = word.gsub(/./,"-")
  end

  def check_win_or_lose
    return :lose if @wrong_guesses.length > 6
    return :win unless @word_with_guesses.match('-')
    return :play
  end

  attr_accessor :word, :guesses, :wrong_guesses, :word_with_guesses

  def guess(letter)
    raise ArgumentError unless letter.instance_of?(String) && letter.match(/\A[a-zA-z]\z/)
    letter.downcase!
    return false if @guesses.include?(letter) || @wrong_guesses.include?(letter)

    if @word.include? letter
      @guesses.concat(letter)
      @word.each_char.with_index {|char, index| @word_with_guesses[index] = letter if char == letter}
    else
      @wrong_guesses.concat(letter)
    end

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
