require './qb/entities/vendor'
Dir['./hireverse/vendors/*.rb'].each {|file| require file}


class VendorFactory

	# note: 
	# in order for this VendorFactory to work, every sub-class of
	# Vendor must implement the default constructor.
	def self.build(vendor_name)
		begin
			vendor_name.gsub!(" ", "_")
			clz = Object.const_get(vendor_name)
			clz.new
		rescue => e
			puts "The VendorFactory failed to instantiate " + vendor_name + "."
			nil
		end
	end

end