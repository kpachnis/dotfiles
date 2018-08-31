# vim: ft=ruby

Pry.editor = ENV['VISUAL']
Pry.config.history.file = if defined?(Bundler)
                            Bundler.tmp.parent.join('history.rb')
                          else
                            File.expand_path('~/.history.rb')
                          end

begin
  require 'pry-editline'
rescue LoadError
end

