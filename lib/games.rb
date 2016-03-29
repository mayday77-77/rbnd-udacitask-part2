class GameItem < LinkItem

	attr_accessor :game_title, :type

	def initialize(url, options = {})
		super(url, options)
		@type = "game"
		@game_title = options[:game_title]
	end

	def details
		super + " [Game: #{@game_title}]"
	end
end