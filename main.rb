require_relative "lib/skeleton"
skeleton = Skeleton.new "bigger.json"
puts "PRISTINE? #{skeleton.pristine? ? "YES" : "NO"}"
