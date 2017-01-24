require './qb/depreciation/methods/basic_depreciation_method'


class HY_5YR < BasicDepreciationMethod

	protected
	def schedule
		[0.2000, 0.3200, 0.1920, 0.1152, 0.1152, 0.0576]
	end

end