require './qb/depreciation/methods/basic_depreciation_method'


class MQ1_5YR < BasicDepreciationMethod

	protected
	def schedule
		[0.3500, 0.2600, 0.1560, 0.1101, 0.1101, 0.0138]
	end

	public
	def valid_purchase_date?(purchase_date)
		purchase_date.month >= 1 and purchase_date.month <= 3
	end

end