class Node
	attr_accessor :value, :next, :x, :y

	def initialize(pointer, x, y)
		@next = pointer
		@x = x
		@y = y
	end
end