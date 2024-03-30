class Player
  attr_accessor :name, :moves, :total_missiles, :battleship_board
  
  def initialize(name, total_missiles, moves, battleship_board)
    @name = name
    @moves = moves.split(":")
    @total_missiles = total_missiles
    @battleship_board = battleship_board
  end
  
  def hit_by_oppnent(opponent_moves)
    wins_p1 = 0
    opponent_moves.each do |move_pos|
      i, j = move_pos.split(",")
      
      if battleship_board.board[i.to_i][j.to_i] == "B"
        battleship_board.board[i.to_i][j.to_i] = "x"
        wins_p1 += 1
      elsif battleship_board.board[i.to_i][j.to_i] == "-"
        battleship_board.board[i.to_i][j.to_i] = "o"
      end
    end
    wins_p1
  end
end

class BattleShipBoard # Grid with M*M
  attr_accessor :size, :total_ships, :ship_position, :board
  
  def initialize(size, total_ships, ship_position)
    @board = []
    @size = size

    if total_ships > (size**2/2)
      raise "total ships can be place on #{size}x#{size} grid between (0 < S <= M^2/2) i.e. (0 < S <= #{(size^2/2).round}"
    end
     
    @total_ships = total_ships
    @ship_position = ship_position.split(":")
  end
  
  def place_ships_on_board
    ship_position.each do |pos|
    i, j = pos.split(",")
    board[i.to_i][j.to_i] = "B"
  end
  end
  
  def prepare_board
    for i in 0..(size - 1)
      board[i] = []
      (0..(size-1)).each do
        board[i].append('-')
      end
    end
    place_ships_on_board
  end
end

class Game
  attr_accessor :player1, :player2
  def initialize(board_size:, total_ships:, player1_ship_pos:, player2_ship_pos:, total_missiles:, player1_moves:, player2_moves:)
    b1 = BattleShipBoard.new(board_size, total_ships, player1_ship_pos)
    b2 = BattleShipBoard.new(board_size, total_ships, player2_ship_pos)
    b1.prepare_board
    b2.prepare_board
    
    @player1 = Player.new("player1", total_missiles, player1_moves, b1)
    @player2 = Player.new("player2", total_missiles, player2_moves, b2)
  end
  
  def display_board
    puts "player1 name: #{player1.name}, final board output:"
    player1.battleship_board.board.each{|b| p b}
    
    puts "\nplayer2 name: #{player2.name}, final board output:"
    player2.battleship_board.board.each{|b| p b}
  end
  
  def start
    p1_hit = player1.hit_by_oppnent(player2.moves)
    p2_hit = player2.hit_by_oppnent(player1.moves)
    
    display_board
    puts "player1 hits: #{p1_hit}"
    puts "player2 hits: #{p2_hit}"
    
    if p1_hit > p2_hit
      p "Player 1 wins"
    elsif p2_hit > p1_hit
      p "Player 2 wins"
    else
      p "It is a draw"
    end
  end
end
g = Game.new(board_size: 5, total_ships: 5, player1_ship_pos: "1,1:2,0:2,3:3,4:4,3", player2_ship_pos: "0,1:2,3:3,0:3,4:4,1", total_missiles: 5, player1_moves: "0,1:4,3:2,3:3,1:4,1", player2_moves: "0,1:0,0:1,1:2,3:4,3")
g.start
