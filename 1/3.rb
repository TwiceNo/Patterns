puts "What's your favorite programming language?"
lang = gets.chomp
case lang
when "Ruby", "ruby"
	puts "Don't be so flunky :)"
when "Python", "python"
	puts "Great choice, I like it too"
else
	puts "Soon it'll change to Ruby"
end