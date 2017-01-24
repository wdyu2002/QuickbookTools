

class Account
	# static columns.
	class << self; attr_accessor :columns end
	@columns = [ "ACCNT", "NAME", "ACCNTTYPE", "DESC" ]

	public
	attr_accessor :name

	def initialize(account_name, account_type, description = "")
		@name = account_name

		# initialize instance vars.
		@data = Hash[Account.columns.map { |k| [k, ""]}]
		@data["ACCNT"] = "ACCNT"
		@data["NAME"] = account_name
		@data["ACCNTTYPE"] = account_type
		@data["DESC"] = description
	end
	
	def to_s
		# append header.
		str = ""
		str << "\n"
		str << "\n"
		str << "!" << @data.keys.join("\t")
		str << "\n"
		str << @data.values.join("\t")
		str
	end

end
