require './hireverse/parsers/parser'
require './hireverse/parsers/check_parser'
require './hireverse/parsers/general_journal_parser'
require './hireverse/parsers/income_parser'
require './hireverse/parsers/reimbursement_parser'


class ParserFactory

	def self.build(tx_type)
	  case tx_type
	  when "INCOME"
	  	IncomeParser.new
	  when "GENERAL JOURNAL"
	  	GeneralJournalParser.new
	  when "REIMBURSE: 20%"
	  	ReimbursementParser.new(20)
	  when "REIMBURSE: 50%"
	  	ReimbursementParser.new(50)
	  when "REIMBURSE: 100%"
	  	ReimbursementParser.new
	  when "CHECK"
	  	CheckParser.new
	  else
	  	puts "The ParserFactory failed to instantiate " + tx_type + "."
	  	nil
	  end

	end

end