require './qb/entities/account'
require './qb/entities/general_journal'
require './qb/entities/general_journal_ptt'


class AssetDepreciator

	# note:
	# all assets know how to depreciate themselves based on the model data provided.
	# this method provides the necessary iif entries for the depreciated asset for the given year.
	def self.depreciate(asset, year)
		asset_first_year = asset.purchase_date.year
		asset_last_year = asset.sold_date.nil? ? nil : asset.sold_date.year
		
		# assert date-range for asset depreciation.
		return "" if year < asset_first_year
		return "" if !asset_last_year.nil? and year > asset_last_year

		# calculate the depreciation for this year and the next.
		depreciation_for_this_year = asset.depreciation_method.depreciate(asset.cost, year - asset_first_year + 1)
		depreciation_for_next_year = asset.depreciation_method.depreciate(asset.cost, year - asset_first_year + 2)

		# make sure we have depreciation for this year.
		return "" unless depreciation_for_this_year > 0

		# record depreciation.
		content = ""
		# handle first year of depreciation.
		(content << AssetDepreciator.purchase_entry(asset, year)) if asset_first_year == year
		# handle annual depreciation.
		(content << AssetDepreciator.annual_depreciation_entry(asset, year, depreciation_for_this_year))
		# handle asset sold this year, but is not fully depreciated after this year.
		(content << AssetDepreciator.sale_entry(asset, year)) if asset_last_year == year and depreciation_for_next_year > 0
		# return content.
		content
	end

	def self.purchase_entry(asset, depreciation_year)
		# accounts setup.
		str = ""
		str << Account.new("Fixed Assets:#{asset.name}", "FIXASSET").to_s
		str << Account.new("Fixed Assets:#{asset.name}:Cost", "FIXASSET").to_s
		str << Account.new("Fixed Assets:#{asset.name}:Depreciation", "FIXASSET").to_s

		credit_account = Account.new("Bank:Spendings", "BANK")
		debit_account  = Account.new("Fixed Assets:#{asset.name}:Cost", "FIXASSET")
		str << GeneralJournal.new(asset.purchase_date, asset.cost, debit_account.name, credit_account.name, "#{depreciation_year} purchase of #{asset.name}").to_s
		str
	end

	def self.annual_depreciation_entry(asset, depreciation_year, depreciation_amount)
		credit_account = Account.new("Fixed Assets:#{asset.name}:Cost", "FIXASSET")
		debit1_account = Account.new("Fixed Assets:#{asset.name}:Depreciation", "FIXASSET")
		debit2_account = Account.new("Depreciables:#{depreciation_year} Depreciables", "EXP")
		
		GeneralJournal_PassThroughTransaction.new(DateTime.new(depreciation_year, 12, 31), depreciation_amount, debit2_account.name, debit1_account.name, credit_account.name, "#{depreciation_year} depreciation for #{asset.name}").to_s
	end

	def self.sale_entry(asset, depreciation_year)
		credit_account = Account.new("Fixed Assets:#{asset.name}:Cost", "FIXASSET")
		debit1_account = Account.new("Proceeds from Sale of Assets", "EXINC")
		debit2_account = Account.new("Bank:Income - Sales", "BANK")

		GeneralJournal_PassThroughTransaction.new(DateTime.new(depreciation_year, 12, 31), AssetDepreciator.undepreciated_amount_from_asset(asset), debit2_account.name, debit1_account.name, credit_account.name, "#{depreciation_year} sale of #{asset.name}").to_s
	end

	# note:
	# calculates the undepreciated after this year (because we assume sale date of 12/31).
	private
	def self.undepreciated_amount_from_asset(asset)
		undepreciated = asset.cost
		(asset.purchase_date.year .. asset.sold_date.year).each do |year|
			undepreciated = (undepreciated - asset.depreciation_method.depreciate(asset.cost, year - asset.purchase_date.year + 1)).round(2)
		end
		return undepreciated
	end

end
