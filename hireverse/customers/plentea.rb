require './qb/entities/customer'


class Plentea < Customer

	def initialize
		super(
			:refnum => 1,
			:company_name => "Plentea",
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
