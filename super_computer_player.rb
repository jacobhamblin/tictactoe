require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    root = TicTacToeNode.new(game.board, mark)
    root.children.each do |child|
      return child.prev_move_pos if child.winning_node?(mark)
    end
    root.children.each do |child|
      return child.prev_move_pos unless child.losing_node?(mark)
    end

    raise "We are not so smart"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = ComputerPlayer.new
  cp = SuperComputerPlayer.new("Starfinder 3000")

  TicTacToe.new(hp, cp).run
end
