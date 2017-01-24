require 'Date'
require './qb/entities/transaction'
require './qb/entities/split'


class Payment
	private
	attr_accessor :transactions

	public

	def initialize(job, date, amount, debit, credit, description)
		transaction = Transaction.new
		transaction.data["TRNSTYPE"] = "PAYMENT"
		transaction.data["DATE"] = date.strftime("%m/%d/%y")
		transaction.data["ACCNT"] = debit # Bank:Income - Services
		transaction.data["NAME"] = job.data["NAME"]
		transaction.data["AMOUNT"] = amount
		transaction.data["DOCNUM"] = "DD"
		transaction.data["MEMO"] = description
		transaction.data["CLEAR"] = "Y"
		transaction.data["PAYMETH"] = "Check"
		transaction.data["ADDR1"] = job.data["BADDR1"]
		transaction.data["ADDR2"] = job.data["BADDR2"]
		transaction.data["ADDR3"] = job.data["BADDR3"]
		transaction.data["ADDR4"] = job.data["BADDR4"]

		split = Split.new
		split.data["TRNSTYPE"] = "PAYMENT"
		split.data["DATE"] = date.strftime("%m/%d/%y")
		split.data["ACCNT"] = credit # Accounts Receivable
		split.data["NAME"] = job.data["NAME"]
		split.data["AMOUNT"] = -amount
		split.data["DOCNUM"] = "DD"
		split.data["MEMO"] = description
		split.data["CLEAR"] = "Y"
		split.data["TAXABLE"] = "N"
		split.data["VALADJ"] = "N"
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