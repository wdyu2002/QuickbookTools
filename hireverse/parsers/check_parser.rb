require 'Date'
require './hireverse/parsers/parser'
require './hireverse/vendor_factory'
require './qb/entities/check'


#
# note: currently we parse each line separately, which means there's a
# duplicated vendor line for every job. this can be changed by making
# this CheckParser a singleton, controlling a static vendors array.
#
class CheckParser < Parser

	def initialize

	end

	def parse(row)
		return "" if row.description.nil?
		vendor = VendorFactory.build(row.description.match('(^.*?)\s-')[1])
		return "" if vendor.nil?
		check = Check.new(vendor, row.date, row.amount, row.debit, row.credit, row.description)

		str = ""
		str << vendor.to_s
		str << check.to_s
		str
	end

end