require 'Date'
require './qb/depreciation/depreciation_method_factory'


class Asset

	# asset properties.
	attr_accessor :name, :cost, :purchase_date, :sold_date, :depreciation_method

	def initialize(values = {})
		# validate required symbols exist in the values input.
		[:name, :cost, :purchase_date, :sold_date, :depreciation_method].each { |sym| (raise RuntimeError.new, 'Asset is missing the required ' + sym.to_s + ' field.') unless values.key?(sym) and !values[sym].nil? }

		@name = values[:name]
		@cost = values[:cost].to_f
		@purchase_date = values[:purchase_date].empty? ? nil : DateTime.strptime(values[:purchase_date], "%m/%d/%y")
		@sold_date = values[:sold_date].empty? ? nil : DateTime.strptime(values[:sold_date], "%m/%d/%y")
		@depreciation_method = DepreciationMethodFactory.build(values[:depreciation_method])
		(raise RuntimeError, "Invalid depreciation method for given purchase date: " + purchase_date) unless @depreciation_method.valid_purchase_date?(@purchase_date)
	end

end
