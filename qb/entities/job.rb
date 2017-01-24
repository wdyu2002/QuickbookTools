require 'Date'
require './qb/entities/invoice'
require './qb/entities/payment'


class Job
	# static columns.
	class << self; attr_accessor :columns end
	@columns = [ "CUST", "NAME", "REFNUM", "TIMESTAMP", "BADDR1", "BADDR2", "BADDR3", "BADDR4", "BADDR5", "PHONE1", "PHONE2", "FAXNUM", "EMAIL", "CONT1", "CONT2", "CTYPE", "TERMS", "TAXABLE", "LIMIT", "RESALENUM", "REP", "TAXITEM", "NOTEPAD", "SALUTATION", "COMPANYNAME", "FIRSTNAME", "MIDINIT", "LASTNAME", "CUSTFLD1", "CUSTFLD2", "CUSTFLD3", "CUSTFLD4", "CUSTFLD5", "CUSTFLD6", "CUSTFLD7", "CUSTFLD8", "CUSTFLD9", "CUSTFLD10", "CUSTFLD11", "CUSTFLD12", "CUSTFLD13", "CUSTFLD14", "CUSTFLD15", "JOBDESC", "JOBTYPE", "JOBSTATUS", "JOBSTART", "JOBPROJEND", "JOBEND" ]
	
	private
	attr_accessor :invoice, :payment

	public
	attr_accessor :data

	def initialize(customer, date, amount, debit, credit, description)
		company_name = customer.data["NAME"]

		# initialize instance vars.
		@data = Hash[Job.columns.map { |k| [k, ""]}]
		@data["CUST"] = "CUST"
		@data["NAME"] = "%s:%s (Paid %s)" % [company_name, company_name, date.strftime("%Y/%m/%d")]
		@data["TIMESTAMP"] = "0"
		@data["BADDR1"] = customer.data["BADDR1"]
		@data["BADDR2"] = customer.data["BADDR2"]
		@data["BADDR3"] = customer.data["BADDR3"]
		@data["PHONE1"] = customer.data["PHONE1"]
		@data["EMAIL"] = customer.data["EMAIL"]
		@data["TAXABLE"] = "N"
		@data["COMPANYNAME"] = company_name
		@data["FIRSTNAME"] = customer.data["FIRSTNAME"]
		@data["LASTNAME"] = customer.data["LASTNAME"]
		@data["JOBDESC"] = description
		@data["JOBSTATUS"] = "0"
		@data["JOBSTART"] = "0/0/0"
		@data["JOBPROJEND"] = "0/0/0"
		@data["JOBEND"] = "0/0/0"

		@invoice = Invoice.new(self, date, amount, "Accounts Receivable", credit, description)
		@payment = Payment.new(self, date, amount, debit, "Accounts Receivable", description)
	end

	def to_s
  	# append job.
		str = ""
		str << "\n"
		str << "\n"
		str << "!" << @data.keys.join("\t")
		str << "\n"
		str << @data.values.join("\t")
		
		# append invoice & payments.
		str << @invoice.to_s unless @invoice.nil?
		str << @payment.to_s unless @payment.nil?
		str
	end

end