require 'Date'
require './hireverse/parsers/parser'
require './qb/entities/general_journal'


class GeneralJournalParser < Parser

	def initialize

	end

	def parse(row)
		GeneralJournal.new(row.date, row.amount, row.debit, row.credit, row.description).to_s
	end

end