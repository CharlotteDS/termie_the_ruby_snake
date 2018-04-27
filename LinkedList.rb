load 'Node.rb'

class LinkedList
	attr_accessor :head
	
	def initialize(x, y)
		@head = Node.new(nil, x, y)
	end
	
	def add_node(x, y)
		current = @head
		while current.next != nil
			current = current.next
		end
		current.next = Node.new(nil, x, y)
	end
	
	def add_head(x, y)
		current = @head
		@head = Node.new(nil, x, y)
		@head.next = current
	end
	
	def remove_tail
		current = @head
		while current != nil
			if(current.next.next == nil)
				current.next = nil
				break
			end
			current = current.next
		end
	end
end