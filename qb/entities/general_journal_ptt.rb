require 'Date'
require './qb/entities/transaction'
require './qb/entities/split'


# note:
# a pass-through transaction is a transaction with 3 splits where the amount
# passes through as follows:
# credit1 -> debit1
# credit2 -> debit2, (where credit2 == debit1)
# basically, the amount travels from credit1 to debit2, passing through debit1.
class GeneralJournal_PassThroughTransaction
	private
	attr_accessor :transactions

	public

	def initialize(date, amount, debit2, debit1, credit1, description)
		transaction = Transaction.new
		transaction.data["TRNSTYPE"] = "GENERAL JOURNAL"
		transaction.data["DATE"] = date.strftime("%m/%d/%y")
		transaction.data["ACCNT"] = credit1
		transaction.data["AMOUNT"] = -amount
		transaction.data["MEMO"] = description
		transaction.data["TOPRINT"] = "N"

		split = Split.new
		split.data["TRNSTYPE"] = "GENERAL JOURNAL"
		split.data["DATE"] = date.strftime("%m/%d/%y")
		split.data["ACCNT"] = debit1
		split.data["AMOUNT"] = amount
		split.data["MEMO"] = description
		transaction.add_split(split)

		split = Split.new
		split.data["TRNSTYPE"] = "GENERAL JOURNAL"
		split.data["DATE"] = date.strftime("%m/%d/%y")
		split.data["ACCNT"] = debit1 # debit is now credit.
		split.data["AMOUNT"] = -amount
		split.data["MEMO"] = description
		transaction.add_split(split)

		split = Split.new
		split.data["TRNSTYPE"] = "GENERAL JOURNAL"
		split.data["DATE"] = date.strftime("%m/%d/%y")
		split.data["ACCNT"] = debit2
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