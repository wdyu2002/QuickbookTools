require './qb/depreciation/methods/depreciation_method'


# note:
# IRS has special depreciation rules for passenger vehicles & vans.
# for 2011, the rules state that the Standard depreciation limits are as follows:
#
# First tax year: MAX = $3060
# Second tax year: MAX = $4900
# Third tax year: MAX = $2950
# Subsequent tax years: MAX = $1775
#
class Passenger_Vehicle_2011 < DepreciationMethod

	# note:
	# this method implements the abstract impl_depreciation method.
	protected
	def impl_depreciate(cost, which_year)
		# year always is >= 1.
		year = which_year - 1
		# maximum depreciation amounts for each year. the last index holds the value for all subsequent years.
		amounts = [3060, 4900, 2950, 1775]
		max_i = amounts.length - 1

		depreciation = 0
		(0 .. year).each do |i|
			depreciation = amounts[[i, max_i].min]
			cost -= depreciation
		end

		# there exists more to depreciates.
		return depreciation.round(2) if cost >= 0
		# over-depreciated case.
		return 0 if cost < -depreciation
		# this is the final depreciation for this asset.
		return (depreciation + cost).round(2)
	end

end

# tests ..

# puts '-- depreciate 1000.01 --'
# puts Passenger_Vehicle_2011.new.depreciate(1000.01, 1)
# puts Passenger_Vehicle_2011.new.depreciate(1000.01, 2)
# puts Passenger_Vehicle_2011.new.depreciate(1000.01, 3)

# puts '-- depreciate 2000 --'
# puts Passenger_Vehicle_2011.new.depreciate(2000, 1)
# puts Passenger_Vehicle_2011.new.depreciate(2000, 2)
# puts Passenger_Vehicle_2011.new.depreciate(2000, 3)

# puts '-- depreciate 3059.99 --'
# puts Passenger_Vehicle_2011.new.depreciate(3059.99, 1)
# puts Passenger_Vehicle_2011.new.depreciate(3059.99, 2)
# puts Passenger_Vehicle_2011.new.depreciate(3059.99, 3)

# puts '-- depreciate 3060 --'
# puts Passenger_Vehicle_2011.new.depreciate(3060, 1)
# puts Passenger_Vehicle_2011.new.depreciate(3060, 2)
# puts Passenger_Vehicle_2011.new.depreciate(3060, 3)

# puts '-- depreciate 3060.01 --'
# puts Passenger_Vehicle_2011.new.depreciate(3060.01, 1)
# puts Passenger_Vehicle_2011.new.depreciate(3060.01, 2)
# puts Passenger_Vehicle_2011.new.depreciate(3060.01, 3)

# puts '-- depreciate 7000 --'
# puts Passenger_Vehicle_2011.new.depreciate(7000, 1)
# puts Passenger_Vehicle_2011.new.depreciate(7000, 2)
# puts Passenger_Vehicle_2011.new.depreciate(7000, 3)

# puts '-- depreciate 10000 --'
# puts Passenger_Vehicle_2011.new.depreciate(10000, 1)
# puts Passenger_Vehicle_2011.new.depreciate(10000, 2)
# puts Passenger_Vehicle_2011.new.depreciate(10000, 3)
# puts Passenger_Vehicle_2011.new.depreciate(10000, 4)

# puts '-- depreciate 26618.19 --'
# puts Passenger_Vehicle_2011.new.depreciate(26618.19, 1) # 2011
# puts Passenger_Vehicle_2011.new.depreciate(26618.19, 2)
# puts Passenger_Vehicle_2011.new.depreciate(26618.19, 3)
# puts Passenger_Vehicle_2011.new.depreciate(26618.19, 4)
# puts Passenger_Vehicle_2011.new.depreciate(26618.19, 5)
# puts Passenger_Vehicle_2011.new.depreciate(26618.19, 6)
# puts Passenger_Vehicle_2011.new.depreciate(26618.19, 7)
# puts Passenger_Vehicle_2011.new.depreciate(26618.19, 8)
# puts Passenger_Vehicle_2011.new.depreciate(26618.19, 9)
# puts Passenger_Vehicle_2011.new.depreciate(26618.19, 10)
# puts Passenger_Vehicle_2011.new.depreciate(26618.19, 11)
# puts Passenger_Vehicle_2011.new.depreciate(26618.19, 12) # 2022
# puts Passenger_Vehicle_2011.new.depreciate(26618.19, 13) # 2023
# puts Passenger_Vehicle_2011.new.depreciate(26618.19, 14) # 2024
