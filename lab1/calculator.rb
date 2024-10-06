class Calculator
  def initialize
    @exit_commands = ['exit', 'quit', 'q']
    @history = []
  end

  def start
    puts "A simple calculator. Enter an expression or 'exit' to exit."
    loop do
      print "Enter an expression: "
      handle_input(gets.chomp)
    end
  end

  private

  def handle_input(input)
    case input.downcase
    when *@exit_commands
      puts "Calculator finished."
      exit
    when 'history'
      show_history
    when /^use \d+$/
      use_from_history(input)
    else
      calculate(input)
    end
  end

  def calculate(input)
    begin
      result = eval(input)
      @history << { expression: input, result: result }
      puts "Result: #{result}"
    rescue SyntaxError, StandardError => e
      puts "Error: #{e.message}. Try again."
    end
  end

  def show_history
    if @history.empty?
      puts "History is empty."
    else
      @history.each_with_index { |entry, index| puts "#{index + 1}. #{entry[:expression]} = #{entry[:result]}" }
    end
  end

  def use_from_history(input)
    index = input.split.last.to_i - 1
    if index.between?(0, @history.length - 1)
      result = @history[index][:result]
      puts "Using result from history: #{result}"
      print "Enter a new expression using this result (e.g., ANS + 5): "
      calculate(gets.chomp.gsub('ANS', result.to_s))
    else
      puts "Invalid history entry number."
    end
  end
end

calc = Calculator.new
calc.start
