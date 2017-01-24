require './qb/depreciation/methods/basic_depreciation_method'


class HY_7YR < BasicDepreciationMethod

	protected
	def schedule
		[0.1429, 0.2449, 0.1749, 0.1249, 0.0893, 0.0892, 0.0893, 0.0446]
	end

end