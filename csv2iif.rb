require 'Date'
require 'csv'
require 'json'

require './row'
require './qb/iif/iif_file'
require './hireverse/customer_factory'
require './hireverse/parser_factory'


class CSV2IIF
  
  def self.import(file)
  	# file content always begins with the header.
  	iif = IIFFile.new("~/desktop/output.txt")

  	# parse each income row.
    CSV.foreach(file, { :headers => true, :col_sep => "\t" }) do |row|
      # parse row.
      row = Row.new(row)
      next if row.empty?

      # retrieve proper parser for the given row.
      parser = ParserFactory.build(row.tx_type)
      next if parser.nil?

      # parse row and store content.
      iif.append(parser.parse(row))
    end

    # write parsed content.
    iif.write
  end

end

CSV2IIF.import("~/desktop/input.txt")
