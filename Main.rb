require "curses"
require "io/console"
require "time"

include Curses

load "Board.rb"
load "Game.rb"
load "LinkedList.rb"


@board = Board.new

@ll = LinkedList.new((cols/2), (lines/2))
@game = Game.new(@board, @ll, cols, lines)
@ll.add_node((@ll.head.x-1), (@ll.head.y))
@ll.add_node((@ll.head.x-2), (@ll.head.y))


while(@game.game_over == false)
	@game.pause_game
	@board.draw_board
	@game.control_snake
	@game.move_snake
	@game.create_food
	@game.eat_food
	@game.detect_collision
	@board.win.refresh
	@board.win.clear
	sleep(@game.get_sleep)
end
