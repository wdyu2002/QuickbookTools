require './qb/depreciation/methods/basic_depreciation_method'


class MQ4_7YR < BasicDepreciationMethod

	protected
	def schedule
		[0.0357, 0.2755, 0.1968, 0.1406, 0.1004, 0.0873, 0.0873, 0.0764]
	end

	public
	def valid_purchase_date?(purchase_date)
		purchase_date.month >= 10 and purchase_date.month <= 12
	end

end