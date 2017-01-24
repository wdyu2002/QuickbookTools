require './qb/depreciation/methods/basic_depreciation_method'


class MQ3_7YR < BasicDepreciationMethod

	protected
	def schedule
		[0.1071, 0.2551, 0.1822, 0.1302, 0.0930, 0.0885, 0.0886, 0.0553]
	end

	public
	def valid_purchase_date?(purchase_date)
		purchase_date.month >= 7 and purchase_date.month <= 9
	end

end