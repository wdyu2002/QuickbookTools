require './qb/entities/header'


class IIFFile

	attr_accessor :content, :filename

	def initialize(filename)
		@content = Header.new.to_s
		@filename = filename
	end

	def append(str)
		(@content << str) unless str.nil?
	end

	def write
		File.write(@filename, @content)
	end

end