class VoteDelta
	attr_accessor :up, :down

	def initialize(up, down)
		self.up = up
		self.down = down
	end

	def ==(other)
		up == other.up && down == other.down
	end
end