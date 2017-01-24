require './qb/depreciation/methods/basic_depreciation_method'


class MQ3_5YR < BasicDepreciationMethod

	protected
	def schedule
		[0.1500, 0.3400, 0.2040, 0.1224, 0.1130, 0.0706]
	end

	public
	def valid_purchase_date?(purchase_date)
		purchase_date.month >= 7 and purchase_date.month <= 9
	end

end