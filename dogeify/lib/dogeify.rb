require "dogeify/version"
require 'endtagger'

class Dogeify
	ADJECTIVES = %w (so such very much many).freeze
	
	def initialize
		@tagger = EndTagger.new
	end
	
	def process (str)
		# convert input to lowercase
		str = str.downcase
		
		# exact nouns, prefixing each with one of the
		# above adjectives into sentences of 2 words
		tagged_str = @tagger.add_tags (str)
		phrases = @tagger.get_nouns (tagged_str) .keys
		phrases = phrases.each_with_index.map do |phrase, i|
			"#{adjective (i) } #{phrase}."
		end
		
		# end every input with "wow".
		phrases << 'wow..'
		
		# return a string, separating each sentence
		# with a space
		phrases.join(' ')
	end
	
	private
	
	def adjective (i)
		ADJECTIVES [i % ADJECTIVES.size]
	end
end
