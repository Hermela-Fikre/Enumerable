module Enumerable  
    def my_each
        slef.length.times do |i| yield slef[i]
        end
    end

    def my_each_with_index
        self.length.times { |i| yield self[i], i }
    end

    def my_select
        result_array = []
        self.my_each do |i| result_array << i if yield(i) 
        end
        result_array
    end

end


# TESTS
# [1, 2, 3, 4, 5].my_each { |item| puts item * 2 }
# [1, 2, 3, 4, 5].my_each_with_index { |item, index| puts " #{item} and index is #{index}" }
# puts [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].my_select { |item| item % 2 != 0 }
