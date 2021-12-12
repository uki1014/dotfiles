Pry.commands.alias.command 'c', 'continue'
Pry.commands.alias.command 's', 'step'
Pry.commands.alias.command 'n', 'next'
Pry.commands.alias.command 'f', 'finish'
Pry.commands.alias.command 'd', 'disable-pry'

# Hit Enter to repeat last command
Pry::Commands.command /^$/, "repeat last command" do
  command = Pry.history.to_a.last

  _pry_.run_command(command) unless command == "exit" # 起動直後にenter押下で即終了するのを防ぐ
end

# prompt
Pry.config.prompt = proc do |obj, nest_level, _pry_|
  prompt = ""
  prompt << "#{Pry.config.prompt_name.to_s.blue}"
  prompt << "(#{Pry.view_clip(obj).to_s.cyan})"
  prompt << "[#{RUBY_VERSION.to_s.green}]"
  prompt << "> "
end

# 外部gemのコードを省いた call stack
def caller_products
  caller.reject {|l| l.include?( 'gems' )}
end

# 外部gemのコードのみの call stack
def caller_gems
  caller.select {|l| l.include?( 'gems' )}
end

class String
  def red;    "\e[31m#{self}\e[0m"; end
  def green;  "\e[32m#{self}\e[0m"; end
  def yellow; "\e[33m#{self}\e[0m"; end
  def blue;   "\e[34m#{self}\e[0m"; end
  def magenta;"\e[35m#{self}\e[0m"; end
  def cyan;   "\e[36m#{self}\e[0m"; end
  def bold;   "\e[1m#{self}\e[0m"; end
  def back_blue;   "\e[44m#{self}\e[0m"; end
end
