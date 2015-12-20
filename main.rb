require_relative "lib/skeleton"
skeleton = Skeleton.new "fixtures/bigger.json"
puts "PRISTINE? #{skeleton.pristine? ? "YES" : "NO"}"
binding.pry
