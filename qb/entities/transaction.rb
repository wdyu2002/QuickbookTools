require 'Date'
require './qb/entities/split'


class Transaction
	# static columns.
	class << self; attr_accessor :columns end
	@columns = [ "TRNS", "TRNSID", "TRNSTYPE", "DATE", "ACCNT", "NAME", "CLASS", "AMOUNT", "DOCNUM", "MEMO", "CLEAR", "PAID", "PAYMETH", "TOPRINT", "NAMEISTAXABLE", "TERMS", "ADDR1", "ADDR2", "ADDR3", "ADDR4" ]

	private
	attr_accessor :splits

	public
	attr_accessor :data

	def initialize
		# initialize instance vars.
		@data = Hash[Transaction.columns.map { |k| [k, ""]}]
		@data["TRNS"] = "TRNS"
		@splits = []
	end

	def add_split(split)
		@splits << split
	end

	def to_s
		# append transaction.
		str = "\n"
		str << "\n"
		str << "!" << Transaction.columns.join("\t")
		str << "\n"
		str << "!" << Split.columns.join("\t")
		str << "\n"
		str << "!" << "ENDTRNS"
		str << "\n"
		str << @data.values.join("\t")
		
		# append each split.
		@splits.each { |split| str << split.to_s }
		str << "\n"
		str << "ENDTRNS"
		str
	end

end