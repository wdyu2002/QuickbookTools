require 'Date'
require './qb/entities/transaction'
require './qb/entities/split'


class GeneralJournal
	private
	attr_accessor :transactions

	public

	def initialize(date, amount, debit, credit, description)
		transaction = Transaction.new
		transaction.data["TRNSTYPE"] = "GENERAL JOURNAL"
		transaction.data["DATE"] = date.strftime("%m/%d/%y")
		transaction.data["ACCNT"] = credit # Bank:Spendings
		transaction.data["AMOUNT"] = -amount
		transaction.data["MEMO"] = description
		transaction.data["TOPRINT"] = "N"

		split = Split.new
		split.data["TRNSTYPE"] = "GENERAL JOURNAL"
		split.data["DATE"] = date.strftime("%m/%d/%y")
		split.data["ACCNT"] = debit # Deductible Expenses:Auto and truck
		split.data["AMOUNT"] = amount
		split.data["MEMO"] = description
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
		str << "\n"
		str << "\n"
		@transactions.each { |transaction| str << transaction.to_s }
		str
	end

end