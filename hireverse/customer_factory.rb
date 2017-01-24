require './qb/entities/customer'
Dir['./hireverse/customers/*.rb'].each {|file| require file}


class CustomerFactory

	# note: 
	# in order for this CustomerFactory to work, every sub-class of
	# Customer must implement the default constructor.
	def self.build(customer_name)
		begin
			customer_name.gsub!(" ", "_")
			clz = Object.const_get(customer_name)
			clz.new
		rescue => e
			puts "The CustomerFactory failed to instantiate " + customer_name + "."
			nil
		end
	end

end