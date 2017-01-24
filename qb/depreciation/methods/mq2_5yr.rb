require './qb/depreciation/methods/basic_depreciation_method'


class MQ2_5YR < BasicDepreciationMethod

	protected
	def schedule
		[0.25, 0.30, 0.18, 0.1137, 0.1137, 0.0426]
	end

	public
	def valid_purchase_date?(purchase_date)
		purchase_date.month >= 4 and purchase_date.month <= 6
	end

end