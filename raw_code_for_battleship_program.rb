p1 = []
for i in 0..4
  p1[i] = []
  (0..4).each do
    p1[i].append('-')
  end
end

p p1_ship_pos = "1,1:2,0:2,3:3,4:4,3".split(":")

p1_ship_pos.each do |pos|
  i, j = pos.split(",")
  p1[i.to_i][j.to_i] = "B"
end

p1.each {|v| p v}

p2 = []
for i in 0..4
  p2[i] = []
  (0..4).each do
    p2[i].append('-')
  end
end

p p2_ship_pos = "0,1:2,3:3,0:3,4:4,1".split(":")

p2_ship_pos.each do |pos|
  i, j = pos.split(",")
  p2[i.to_i][j.to_i] = "B"
end

p2.each {|v| p v}

total_missile = 5
wins_p1 = 0

p1_moves = "0,1:4,3:2,3:3,1:4,1".split(":")
p1_moves.each do |move_pos|
  i, j = move_pos.split(",")
  
  if p2[i.to_i][j.to_i] == "B"
    p2[i.to_i][j.to_i] = "x"
    wins_p1 += 1
  elsif p2[i.to_i][j.to_i] == "-"
    p2[i.to_i][j.to_i] = "o"
  end
end
p "====:: p2"
p2.each {|v| p v}
p "p1 hits: "
p wins_p1

wins_p2 = 0

p2_moves = "0,1:0,0:1,1:2,3:4,3".split(":")
p2_moves.each do |move_pos|
  i, j = move_pos.split(",")
  
  if p1[i.to_i][j.to_i] == "B"
    p1[i.to_i][j.to_i] = "x"
    wins_p2 += 1
  elsif p1[i.to_i][j.to_i] == "-"
    p1[i.to_i][j.to_i] = "o"
  end
end
p "====:: p1"
p1.each {|v| p v}
p "p2 hits: "
p wins_p2

if wins_p1 > wins_p2
  p "Player 1 wins"
elsif wins_p2 > wins_p1
  p "Player 2 wins"
else
  p "it is a draw"
end
