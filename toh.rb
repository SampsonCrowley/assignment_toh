class TOH
	def initialize(stack_size=4,rods=3,target_rod=2)
		@stack_size = stack_size
		p "stack_size: #{@stack_size}"
		@rods = []
    @target_rod = target_rod
    p "goal: #{@target_rod+1}"
		rods.times {|i| @rods << []}
		
		@stack_size.downto(1) {|plate| @rods[0] << plate}
		p "rods: #{@rods}"
    @goal = @rods[0].dup
    play
	end
  def win?
    @goal == @rods[@target_rod]
  end
  def play
    until win?
      move
    end
    p "Congratulations, You won!"
  end
  def valid? rod, target
    return true
  end
	def move
    p "Where would you like to move from?"
    rod = gets.chomp.to_i
    p "Where would you like to move?(\#1-#{@rods.length})"
    target = gets.chomp.to_i
    if valid?(rod,target)
      p @rods[rod-1]
      p @rods[rod-1][-1] 
      @rods[target-1] << @rods[rod-1][-1] 
      @rods[rod-1].pop
      p @rods[target-1]
    end
	end
end

TOH.new 4, 3