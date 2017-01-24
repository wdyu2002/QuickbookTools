require 'Date'
require './qb/entities/job'


class Customer
	# static columns.
	class << self; attr_accessor :columns end
	@columns = [ "CUST", "NAME", "REFNUM", "TIMESTAMP", "BADDR1", "BADDR2", "BADDR3", "BADDR4", "BADDR5", "PHONE1", "PHONE2", "FAXNUM", "EMAIL", "CONT1", "CONT2", "CTYPE", "TERMS", "TAXABLE", "LIMIT", "RESALENUM", "REP", "TAXITEM", "NOTEPAD", "SALUTATION", "COMPANYNAME", "FIRSTNAME", "MIDINIT", "LASTNAME", "CUSTFLD1", "CUSTFLD2", "CUSTFLD3", "CUSTFLD4", "CUSTFLD5", "CUSTFLD6", "CUSTFLD7", "CUSTFLD8", "CUSTFLD9", "CUSTFLD10", "CUSTFLD11", "CUSTFLD12", "CUSTFLD13", "CUSTFLD14", "CUSTFLD15", "JOBDESC", "JOBTYPE", "JOBSTATUS", "JOBSTART", "JOBPROJEND", "JOBEND" ]

	public
	attr_accessor :data

	def initialize(company_info)
		# parse data input into vars.
		refnum = company_info[:refnum] || 0
		company_name = company_info[:company_name] || ""
		first_name = company_info[:first_name] || ""
		last_name = company_info[:last_name] || ""
		business_address = ["", "", "", "", ""]
		business_address[0] = [first_name, last_name].join(" ")
		business_address[1] = company_info[:address] || ""
		business_address[2] = []
		business_address[2] << company_info[:city] if company_info.key?(:city)
		business_address[2] << company_info[:state] if company_info.key?(:state)
		business_address[2] << company_info[:zip] if company_info.key?(:zip)
		business_address[2] = business_address[2].join(", ")
		phone = company_info[:phone] || ""
		email = company_info[:email] || ""
		
		# initialize instance vars.
		@jobs = []
		@data = Hash[Customer.columns.map { |k| [k, ""]}]
		@data["CUST"] = "CUST"
		@data["NAME"] = company_name
		@data["REFNUM"] = refnum
		@data["TIMESTAMP"] = "0"
		@data["BADDR1"] = business_address[0]
		@data["BADDR2"] = business_address[1]
		@data["BADDR3"] = business_address[2]
		@data["PHONE1"] = phone
		@data["EMAIL"] = email
		@data["TAXABLE"] = "N"
		@data["COMPANYNAME"] = company_name
		@data["FIRSTNAME"] = first_name
		@data["LASTNAME"] = last_name
		@data["JOBSTATUS"] = "0"
		@data["JOBSTART"] = "0/0/0"
		@data["JOBPROJEND"] = "0/0/0"
		@data["JOBEND"] = "0/0/0"
	end

  def to_s
  	# append customer.
		str = ""
		str << "\n"
		str << "\n"
		str << "!" << @data.keys.join("\t")
		str << "\n"
		str << @data.values.join("\t")
		str
  end

end
