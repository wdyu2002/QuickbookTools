require './qb/depreciation/methods/basic_depreciation_method'


class MQ2_7YR < BasicDepreciationMethod

	protected
	def schedule
		[0.1785, 0.2347, 0.1676, 0.1197, 0.0887, 0.0887, 0.0887, 0.0333]
	end

	public
	def valid_purchase_date?(purchase_date)
		purchase_date.month >= 4 and purchase_date.month <= 6
	end

end