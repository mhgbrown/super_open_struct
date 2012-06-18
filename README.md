# SuperOpenStruct
As an exercise, I wanted to see if I could extend OpenStruct to define methods using blocks to accomplish something like this:

	@sos = SuperOpenStruct.new
	@sos.foo do |a, b|
      a ** b
    end

    >> @sos.foo(2, 3)
	>> 8

SuperOpenStruct is the result of that effort.