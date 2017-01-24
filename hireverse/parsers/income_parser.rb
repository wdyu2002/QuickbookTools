require 'Date'
require './hireverse/parsers/parser'
require './hireverse/customer_factory'
require './qb/entities/job'


#
# note: currently we parse each line separately, which means there's a
# duplicated customer line for every job. this can be changed by making
# this IncomeParser a singleton, controlling a static customers array.
#
class IncomeParser < Parser

	def initialize
		
	end

	def parse(row)
		return "" if row.description.nil?
		customer = CustomerFactory.build(row.description.match('(^.*?)\s-')[1])
		return "" if customer.nil?
		job = Job.new(customer, row.date, row.amount, row.debit, row.credit, row.description)

		str = ""
		str << customer.to_s
		str << job.to_s
		str
	end

end