require 'Date'


class Row
	private
	attr_accessor :empty

	public
	attr_accessor :account, :date, :tx_type, :amount, :debit, :credit, :description

  def initialize(row)
  	# ensure row content.
  	return if row["Date"].nil?

    @account = row["Account"]
    @date = DateTime.strptime(row["Date"], "%m/%d/%y")
    @tx_type = row["Tx Type"]
    @amount = row["Amount"].to_f
    @debit = row["Debit"]
    @credit = row["Credit"]
    @description = row["Description"]
    @empty = false
  end

  def empty?
  	@empty.nil? or @empty
  end

end