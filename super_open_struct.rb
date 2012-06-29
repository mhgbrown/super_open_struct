require 'ostruct'

class SuperOpenStruct < OpenStruct
  def [](key)
    @table[key.to_sym]
  end

  def []=(key, value)
    @table[key.to_sym] = value
    new_ostruct_member(key, nil)
  end

  def method_missing(mid, *args, &block) # :nodoc:
    #check for the block first
    mname = mid.id2name
    len = args.length
    if block_given?
      self.new_ostruct_member(mname, &block)
      @table[mname.intern] = block
    elsif mname =~ /=$/
      if len != 1
        raise ArgumentError, "wrong number of arguments (#{len} for 1)", caller(1)
      end
      if self.frozen?
        raise TypeError, "can't modify frozen #{self.class}", caller(1)
      end
      mname.chop!
      self.new_ostruct_member(mname, &block)
      @table[mname.intern] = args[0]
    elsif len == 0
        @table[mid]
    else
      raise NoMethodError, "undefined method `#{mname}' for #{self}", caller(1)
    end
  end

  def new_ostruct_member(name, &block)
    puts block
    name = name.to_sym
    unless self.respond_to?(name)
      meta = class << self; self; end
      if block_given?
        meta.send(:define_method, name) { |*args| @table[name].call(*args) }
      else
        meta.send(:define_method, name) { @table[name] }
        meta.send(:define_method, "#{name}=""#{name}=") { |x| @table[name] = x }
      end
    end
  end


end
