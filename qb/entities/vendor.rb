require 'Date'


class Vendor
	# static columns.
	class << self; attr_accessor :columns end
	@columns = [ "VEND", "NAME", "ADDR1", "ADDR2", "ADDR3", "ADDR4", "ADDR5", "VTYPE", "PHONE1", "PHONE2", "FAXNUM", "EMAIL", "CONT1", "CONT2", "NOTE", "TAXID", "LIMIT", "TERMS", "NOTEPAD", "SALUTATION", "COMPANYNAME", "FIRSTNAME", "MIDINIT", "LASTNAME", "PRINTAS" ]

	public
	attr_accessor :data

	def initialize(vendor_info)
		# parse data input into vars.
		vendor_name = vendor_info[:vendor_name] || ""
		first_name = vendor_info[:first_name] || ""
		last_name = vendor_info[:last_name] || ""
		business_address = ["", "", "", "", ""]
		business_address[0] = vendor_info[:address1] || ""
		business_address[1] = vendor_info[:address2] || ""
		business_address[2] = []
		business_address[2] << vendor_info[:city] if vendor_info.key?(:city)
		business_address[2] << vendor_info[:state] if vendor_info.key?(:state)
		business_address[2] << vendor_info[:zip] if vendor_info.key?(:zip)
		business_address[2] = business_address[2].join(", ")
		phone = vendor_info[:phone] || ""
		email = vendor_info[:email] || ""
		note = vendor_info[:note] || ""
		
		# initialize instance vars.
		@jobs = []
		@data = Hash[Vendor.columns.map { |k| [k, ""]}]
		@data["VEND"] = "VEND"
		@data["NAME"] = vendor_name
		@data["ADDR1"] = business_address[0]
		@data["ADDR2"] = business_address[1]
		@data["ADDR3"] = business_address[2]
		@data["PHONE1"] = phone
		@data["EMAIL"] = email
		@data["COMPANYNAME"] = vendor_name
		@data["FIRSTNAME"] = first_name
		@data["LASTNAME"] = last_name
		@data["NOTE"] = note
	end

  def to_s
  	# append vendor.
		str = ""
		str << "\n"
		str << "\n"
		str << "!" << @data.keys.join("\t")
		str << "\n"
		str << @data.values.join("\t")
		str
  end

end
