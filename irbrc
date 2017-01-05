require 'irb/completion'
require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:EVAL_HISTORY] = 10
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:USE_READLINE] = true

# pretty print
require 'pp'

# are we in jirb?
def using_jruby?
	(defined? RUBY_ENGINE != nil) and RUBY_ENGINE == 'jruby'
end

# shutting irb up - with irb_stfu!
def irb_return_format; IRB.conf[:PROMPT][ IRB.conf[:PROMPT_MODE] ][:RETURN]; end
def irb_return_format=(str); irb_return_format.replace(str); end
def irb_stfu!; self.irb_return_format = ''; end
def irb_set_normal_return_format; self.irb_return_format = "=> %s\n"; end

# autoload current work stuff
autoload_file = "#{ENV['HOME']}/.irb_autoload"
if File.exists? autoload_file
	puts "~/.irb_autoload found"
	load autoload_file
else
	puts "~/.irb_autoload not found"
end
