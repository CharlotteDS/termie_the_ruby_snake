require 'colorize'
require 'curses'

include Curses
Curses.cbreak
Curses.noecho
Curses.stdscr.nodelay = 1
Curses.start_color
Curses.init_pair(COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW)
Curses.init_pair(COLOR_RED, COLOR_RED, COLOR_RED)

class Board
	
	attr_accessor :win, :score, :level, :height, :width
	
	def initialize
		@score = 0
		@level = 1
	end
	
	def draw_board
		init_screen
		curs_set(0)
		@height = lines - 1
		@width = cols - 1
		@win = Window.new(lines,cols,0,0)
		@win.setpos(0,0)
		@win.addstr("\n [q] quit [space] pause" + "     TERMIE THE RUBY SNAKE     " + "Level: "+@level.to_s + " Score: " + @score.to_s)
		@win.box("*","*")
		@win.refresh
	end

end
