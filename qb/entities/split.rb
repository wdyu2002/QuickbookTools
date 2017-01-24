require 'Date'


class Split
	# static columns.
	class << self; attr_accessor :columns end
	@columns = [ "SPL", "SPLID", "TRNSTYPE", "DATE", "ACCNT", "NAME", "CLASS", "AMOUNT", "DOCNUM", "MEMO", "CLEAR", "PAYMETH", "TAXABLE", "VALADJ", "REIMBEXP", "QNTY", "PRICE", "INVITEM" ]

	public
	attr_accessor :data

	def initialize
		# initialize instance vars.
		@data = Hash[Split.columns.map { |k| [k, ""]}]
		@data["SPL"] = "SPL"
	end

	def to_s
		# append split.
		str = "\n"
		str << @data.values.join("\t")
		str
  end

end