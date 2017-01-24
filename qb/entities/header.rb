require 'Date'


class Header
	# static columns.
	class << self; attr_accessor :columns end
	@columns = [ "HDR", "PROD", "VER", "REL", "IIFVER", "DATE", "TIME" ]

	public
	attr_accessor :data

	def initialize
		date = DateTime.now

		# initialize instance vars.
		@data = Hash[Header.columns.map { |k| [k, ""]}]
		@data["HDR"] = "HDR"
		@data["PROD"] = "QuickBooks 2015 for Macintosh"
		@data["VER"] = "Version 16.0.5.1500"
		@data["REL"] = "Release R6"
		@data["IIFVER"] = "1"
		@data["DATE"] = "%s/%s/%s" % [ date.month, date.day, date.year - 2000 ]
		@data["TIME"] = "1456076490"
	end
	
	def to_s
		# append header.
		str = ""
		str << "!" << @data.keys.join("\t")
		str << "\n"
		str << @data.values.join("\t")
		str
	end

end
