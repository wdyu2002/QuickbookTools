require 'Date'
require './qb/entities/transaction'
require './qb/entities/split'


class Check
	private
	attr_accessor :transactions

	public

	def initialize(vendor, date, amount, debit, credit, description)
		transaction = Transaction.new
		transaction.data["TRNSTYPE"] = "CHECK"
		transaction.data["DATE"] = date.strftime("%m/%d/%y")
		transaction.data["ACCNT"] = credit # Bank:Taxes
		transaction.data["NAME"] = vendor.data["NAME"] # IRS
		transaction.data["AMOUNT"] = -amount
		transaction.data["MEMO"] = description
		transaction.data["CLEAR"] = "Y"
		transaction.data["TOPRINT"] = "N"
		transaction.data["ADDR1"] = vendor.data["ADDR1"]
		transaction.data["ADDR2"] = vendor.data["ADDR2"]
		transaction.data["ADDR3"] = vendor.data["ADDR3"]
		transaction.data["ADDR4"] = vendor.data["ADDR4"]

		split = Split.new
		split.data["TRNSTYPE"] = "CHECK"
		split.data["DATE"] = date.strftime("%m/%d/%y")
		split.data["ACCNT"] = debit # Deductible Expenses:State taxes
		split.data["AMOUNT"] = amount
		split.data["MEMO"] = description
		split.data["CLEAR"] = "Y"
		split.data["REIMBEXP"] = "NONEED"
		transaction.add_split(split)

		# initialize instance vars.
		@transactions = []
		add_transaction(transaction)
	end

	def add_transaction(transaction)
		@transactions << transaction
	end

	def to_s
		# append each transaction.
		str = ""
		@transactions.each { |transaction| str << transaction.to_s }
		str
	end

end
