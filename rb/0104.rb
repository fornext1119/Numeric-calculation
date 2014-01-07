(1..9).each do |i|
    if i % 3 == 0
        print "#{i}, "
    end
end
print "\n"

(1..9).each do |i|
    print "#{i}, " if i % 3 == 0
end
print "\n"

(1..9).each do |i|
    print "#{i}, " unless i % 3 != 0
end
print "\n"
