
class Game
	
	attr_accessor :game_over
	
	def initialize(board, linkedlist, x, y)
		@col = y
		@line = x
		@x = (rand(1..@line-2))
		@y = (rand(1..@col-2))
		@board = board
		@linkedlist = linkedlist
		@direction = 2
		@sleep_val = 0.2
		@paused = false
		@game_over = false
	end
	
	def draw_snake		
		current = @linkedlist.head
		while current != nil
			@board.win.setpos(current.y, current.x)
			@board.win.attron(color_pair(COLOR_RED)|A_NORMAL){@board.win.addstr('S')}
			
			current = current.next
		end
		@board.win.refresh
	end
	
	def create_food
		@board.win.setpos(@y, @x)
		@board.win.attron(color_pair(COLOR_YELLOW)|A_NORMAL){@board.win.addstr('F')}
		@board.win.refresh
	end
	
	def control_snake
		case getch
		when ?w, ?W
			if(@direction != 3)
				@direction = 1
			end
		when ?d, ?D
			if(@direction != 4)
				@direction = 2
			end
		when ?s, ?S
			if(@direction != 1)
				@direction = 3
			end
		when ?a, ?A
			if(@direction != 2)
				@direction = 4
			end
		when ?q, ?Q
			@game_over = true
		when " "
			@paused = true
		end
	end
	
	def move_snake
		if(@direction == 1)
			@linkedlist.add_head(@linkedlist.head.x, (@linkedlist.head.y-1))
		elsif(@direction == 2)
			@linkedlist.add_head((@linkedlist.head.x+1), @linkedlist.head.y)
		elsif(@direction == 3)
			@linkedlist.add_head(@linkedlist.head.x, (@linkedlist.head.y+1))
		else
			@linkedlist.add_head((@linkedlist.head.x-1), @linkedlist.head.y)
		end
		@linkedlist.remove_tail
		draw_snake
	end
	
	def eat_food
		if(@linkedlist.head.x == @x && @linkedlist.head.y == @y)
			if(@direction == 1)
				@linkedlist.add_head(@linkedlist.head.x, (@linkedlist.head.y-1))
			elsif(@direction == 2)
				@linkedlist.add_head((@linkedlist.head.x+1), @linkedlist.head.y)
			elsif(@direction == 3)
				@linkedlist.add_head(@linkedlist.head.x, (@linkedlist.head.y+1))
			else
				@linkedlist.add_head((@linkedlist.head.x-1), @linkedlist.head.y)
			end
			@x = (rand(1..@line-2))
			@y = (rand(1..@col-2))
			@board.score += 1
			
			if((@board.score % 10) == 0 && @board.score != 0)
				@board.level += 1
				@sleep_val *= 0.75 
			end
			draw_snake
		end
	end
	
	def detect_collision
		if(@linkedlist.head.x == 0 || @linkedlist.head.y == 0 || @linkedlist.head.x == @board.width || @linkedlist.head.y == @board.height)
			sleep(0.5)
			@game_over = true
		end
		
		current = @linkedlist.head
		while(current = current.next)
			if(@linkedlist.head.x == current.x && @linkedlist.head.y == current.y)
				@game_over = true
			end
		end
	end
	
	def pause_game
		if(@paused == true)
			while(getch != " ")
				sleep(0.1)
				case getch
				when " "
					@paused = false
					break
				when ?q, ?Q
					@game_over = true
				end
				
				if(@paused == true)
					@board.win.clear
					@board.win.setpos((@board.height/2),(@board.width/2))
					@board.win.addstr("[GAME PAUSED]")
					@board.win.refresh
				end
			end
		end
	end
	
	def get_sleep
		return @sleep_val
	end
end