require './qb/depreciation/methods/depreciation_method'


class BasicDepreciationMethod < DepreciationMethod

	# note:
	# this method allows the concrete sub-class to define the depreciation schedule array.
	protected
	def schedule
		[]
	end

	# note:
	# this method implements the abstract impl_depreciation method.
	protected
	def impl_depreciate(cost, which_year)
		year = which_year - 1
		return 0 if year >= schedule.length
		# result is rounded to 2 decimal places.
		return (cost.to_f * schedule[year]).round(2)
	end

end