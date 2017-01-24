require './qb/depreciation/methods/basic_depreciation_method'


class MQ1_7YR < BasicDepreciationMethod

	protected
	def schedule
		[0.2500, 0.2143, 0.1531, 0.1093, 0.0875, 0.0874, 0.0875, 0.0109]
	end

	public
	def valid_purchase_date?(purchase_date)
		purchase_date.month >= 1 and purchase_date.month <= 3
	end

end