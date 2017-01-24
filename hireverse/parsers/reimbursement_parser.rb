require 'Date'
require './hireverse/parsers/parser'
# require './hireverse/vendors/danny'


class ReimbursementParser < Parser

	attr_accessor :percent

	def initialize(percent = 100)
		@percent = percent.to_f / 100
	end

	def parse(row)
		return "" if row.description.nil?

		str = ""
		str << GeneralJournal.new(row.date, @percent * row.amount, row.debit, row.credit, row.description).to_s
		str << Check.new(Danny.new, row.date, @percent * row.amount, row.credit, "Bank:Reimbursements", "2015 reimbursement for '" + row.description + "'").to_s
		str
	end

end