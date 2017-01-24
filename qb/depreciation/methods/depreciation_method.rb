

# note:
# each depreciation method should know how to depreciate any asset's costs given
# which year it is in the asset's life-cycle.
#
# note:
# this class knows nothing about asset's sold date. it can only provide the theoretical
# depreciation schedule assuming the asset is kept for as many years as it takes to
# depreciate the entire asset.
class DepreciationMethod

	# cost: cost of asset.
	# which_year: 1 = 1st year.
	#             2 = 2nd year.
	#             n = nth year.
	def depreciate(cost, which_year)
		# input validation.
		(raise RuntimeError.new, 'ERROR: Invalid cost value provided: ' + cost.to_s) if cost <= 0
		(raise RuntimeError.new, 'ERROR: Invalid which_year value provided: ' + which_year.to_s) if which_year <= 0
		impl_depreciate(cost, which_year)
	end

	# note:
	# this method is meant to be overridden by the concrete class implementations.
	protected
	def impl_depreciate(cost, which_year)
		0
	end

	# note:
	# this method is meant to be overridden by the concrete class implementations.
	public
	def valid_purchase_date?(purchase_date)
		true
	end

end