module Enumerable
  def my_each
    return to_enum :my_each unless block_given?

    size.times do |i|
      yield self[i]
    end
  end

  def my_each_with_index
    return to_enum :my_each unless block_given?

    size.times { |i| yield self[i], i }
  end

  def my_select
    return to_enum :my_select unless block_given?

    result_array = []
    my_each do |i|
      result_array << i if yield(i)
    end
    result_array
  end

  def my_all?(args = nil) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    result = true
    if args.nil? && !block_given?
      my_each { |x| result = false if x.nil? || !x }
    elsif args.nil?
      my_each { |x| result = false unless yield(x) }
    elsif args.is_a? Regexp
      my_each { |x| result = false unless x.match(args) }
    elsif args.is_a? Module
      my_each { |x| result = false unless x.is_a?(args) }
    else
      my_each { |x| result = false unless x == args }
    end
    result
  end

  def my_any?(args = nil) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    result = false
    if args.nil? && !block_given?
      my_each { |x| result = true unless x.nil? || !x }
    elsif args.nil?
      my_each { |x| result = true if yield(x) }
    elsif args.is_a? Regexp
      my_each { |x| result = true if x.match(args) }
    elsif args.is_a? Module
      my_each { |x| result = true if x.is_a?(args) }
    else
      my_each { |x| result = true if x == args }
    end
    result
  end

  def my_none?(par = nil, &block)
    !my_any?(par, &block)
  end

  def my_count(par = nil)
    result = 0
    if block_given?
      my_each { |i| result += 1 if yield(i) }
    elsif !par.nil?
      my_each { |i| result += 1 if par == i }
    else
      result = length
    end
    result
  end

  def my_map(proc = nil)
    return to_enum :my_map unless block_given?

    result = []
    my_each { |x| result << (proc ? proc.call(x) : yield(x)) }
    result
  end

  def my_inject(*par) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    new_array = is_a?(Array) ? self : to_a
    total = par[0] if par[0].is_a? Integer
    if par[0].is_a?(Symbol) || par[0].is_a?(String)
      sym = par[0]
    elsif par[0].is_a?(Integer)
      sym = par[1] if par[1].is_a?(Symbol) || par[1].is_a?(String)
    end
    if sym
      new_array.my_each { |item| total = total ? total.send(sym, item) : item }
      total
    else
      new_array.my_each { |item| total = total ? yield(total, item) : item }
    end
    total
  end
end

def multiply_els
  my_inject { |total, item| total * item }
end
