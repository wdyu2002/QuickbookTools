require 'Date'
require './qb/entities/transaction'
require './qb/entities/split'


class Invoice
	private
	attr_accessor :transactions

	public

	def initialize(job, date, amount, debit, credit, description)
		transaction = Transaction.new
		transaction.data["TRNSTYPE"] = "INVOICE"
		transaction.data["DATE"] = date.strftime("%m/%d/%y")
		transaction.data["ACCNT"] = debit # Accounts Receivable
		transaction.data["NAME"] = job.data["NAME"]
		transaction.data["AMOUNT"] = amount
		transaction.data["MEMO"] = description
		transaction.data["CLEAR"] = "Y"
		transaction.data["PAID"] = "Y"
		transaction.data["TOPRINT"] = "N"
		transaction.data["NAMEISTAXABLE"] = "N"
		transaction.data["ADDR1"] = job.data["BADDR1"]
		transaction.data["ADDR2"] = job.data["BADDR2"]
		transaction.data["ADDR3"] = job.data["BADDR3"]
		transaction.data["ADDR4"] = job.data["BADDR4"]

		split = Split.new
		split.data["TRNSTYPE"] = "INVOICE"
		split.data["DATE"] = date.strftime("%m/%d/%y")
		split.data["ACCNT"] = credit # Development Income:Services Income
		split.data["NAME"] = job.data["NAME"]
		split.data["AMOUNT"] = -amount
		split.data["MEMO"] = description
		split.data["CLEAR"] = "Y"
		split.data["TAXABLE"] = "N"
		split.data["QNTY"] = -amount.to_f / 70
		split.data["PRICE"] = 70
		split.data["INVITEM"] = "Development"
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
