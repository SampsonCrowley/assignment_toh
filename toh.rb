class TOH
	def initialize(stack_size=4,rods=3,target_rod=2)
		@stack_size, @rods, @target_rod = stack_size, rods, target_rod
    @gameboard = []
		@rods.times {|i| @gameboard << []}
		@stack_size.downto(1) do
      |plate| @gameboard[0] << plate
    end
    @goal = @gameboard[0].dup
    @pickup_line = "Where would you like to pick up a plate from?(\#1-#{@gameboard.length})"
    @pickup_error = "No plates in that location"
    @putdown_line = "Where would you like to move a plate to?(\#1-#{@gameboard.length})"
    @putdown_error = "Plates can only be stacked on larger plates"
    play
	end

  def display_gameboard
    
    grid = []
    full_board = @gameboard

    @stack_size.times do |row|
      grid << []

      @gameboard.each do |column|
        grid[row] << column[row]
      end
    end
    grid.reverse!
    grid.each do |row|
      row.each do |cell|
        cell = cell || 0
        print "#{' '*(@stack_size+1-cell)}#{'##'*cell}#{' '*(@stack_size+1-cell)} | "
      end
      puts " "
    end
    puts "#{'-'*6*(@stack_size+2)}-"
    (1..@rods).each {|num| print "#{' '*@stack_size}0#{num}#{' '*@stack_size}   "}
    print "\n\n"
  end

  def move compare=false
    yield(false)
    rod = gets.chomp.to_i
    until valid?(rod, compare)
      display_gameboard
      yield(true)
      rod = gets.chomp.to_i
    end
    return rod
  end

  def play
    display_gameboard
    until win?
      take_turn
      display_gameboard
    end
    p "Congratulations, You won!"
  end

	def take_turn
    plate, target, first = 0, 0, true
    plate = move do |error|
      if error then puts "\n\n#{@pickup_error}\n\n" end
      puts "\n#{@pickup_line} "
    end
    target = move plate do |error|
      if error then puts "\n\n#{@putdown_error}\n\n" end
      puts "\n#{@putdown_line} "
    end
    @gameboard[target-1] << @gameboard[plate-1][-1]
    @gameboard[plate-1].pop
	end

  def valid? location, size_check=false
    if (1..@rods).include?(location)
      if (size_check)
        return (!@gameboard[location-1][-1] || @gameboard[location-1][-1] >= @gameboard[size_check-1][-1])
      else
        return @gameboard[location-1][-1] != nil
      end
    end
  end

  def win?
    @goal == @gameboard[@target_rod]
  end
end

TOH.new 4, 3