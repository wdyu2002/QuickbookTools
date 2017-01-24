Dir['./qb/depreciation/methods/*.rb'].each {|file| require file}


class DepreciationMethodFactory

	# note:
	# in order for this Factory to work, every sub-class of DepreciationSchedule
	# must implement the static 'schedule' variable.
	def self.build(method_name)
		begin
			Object.const_get(method_name).new
		rescue => e
			puts "The DepreciationMethodFactory failed to instantiate " + method_name + "."
			nil
		end
	end

end