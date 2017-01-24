require './qb/entities/customer'


class RAE_Studios < Customer

	def initialize
		super(
			:refnum => 2,
			:company_name => "RAE Studios",
			:first_name => "",
			:last_name => "",
			:address => "",
			:city => "",
			:state => "",
			:zip => "",
			:phone => "",
			:email => ""
			)
	end
	
end
