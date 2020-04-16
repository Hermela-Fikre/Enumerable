module Enumerable  
    def my_each
        slef.length.times do |i| yield slef[i]
        end
    end
end


# TESTS
# [1, 2, 3, 4, 5].my_each { |item| puts item * 2 }