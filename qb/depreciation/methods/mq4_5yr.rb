require './qb/depreciation/methods/basic_depreciation_method'


class MQ4_5YR < BasicDepreciationMethod

	protected
	def schedule
		[0.0500, 0.3800, 0.2280, 0.1368, 0.1094, 0.0958]
	end

	public
	def valid_purchase_date?(purchase_date)
		purchase_date.month >= 10 and purchase_date.month <= 12
	end

end