require './qb/entities/vendor'


class IRS < Vendor

	def initialize
		super(
			:vendor_name => "IRS",
			:first_name => "",
			:last_name => "",
			:address1 => "DEPARTMENT OF THE TREASURY",
			:address2 => "INTERNAL REVENUE SERVICE CENTER",
			:city => "CINCINNATI",
			:state => "OH",
			:zip => "45999-0012",
			:phone => "",
			:email => "",
			:note => ""
			)
	end
	
end
