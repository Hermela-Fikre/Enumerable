module Enumerable  
    def my_each
        slef.length.times do |i| yield slef[i]
        end
    end

    def my_each_with_index
        self.length.times { |i| yield self[i], i }
    end

end


# TESTS
# [1, 2, 3, 4, 5].my_each { |item| puts item * 2 }
# [1, 2, 3, 4, 5].my_each_with_index { |item, index| puts " #{item} and index is #{index}" }