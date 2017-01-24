require 'Date'
require './qb/iif/iif_file'
require './qb/assets/asset'
require './qb/assets/asset_loader'
require './hireverse/depreciator/asset_depreciator'


class Assets2IIF

	def self.depreciate_assets(assets, start_year, end_year)
		# make sure inputs are valid.
		return "" unless start_year <= end_year

  	# file content always begins with the header.
  	iif = IIFFile.new("~/desktop/depreciation-#{start_year}-#{end_year}.iif")
		
		# for each year, calculate the asset depreciation.
		(start_year .. end_year).each do |year|
	  	assets.values.each do |asset|
  			iif.append(AssetDepreciator.depreciate(asset, year))
  		end
  	end

  	# write written content.
  	iif.write
	end

end

year = DateTime.now.year
assets = AssetLoader.load('./hireverse/assets')
Assets2IIF.depreciate_assets(assets, year, year)
# run iif conversion for any past or future years.
# Assets2IIF.depreciate_assets(assets, 2009, 2015)



# # tests ..

# class MYASSET < Asset
# 	def initialize
# 		super({
# 			:name => "MY ASSET",
# 			:cost => 100.00,
# 			:purchase_date => "8/1/10",
# 			:sold_date => "12/31/12",
# 			:depreciation_method => "MQ3_7YR"
# 			})
# 	end
# end

# assets = {}
# assets[:MYASSET] = MYASSET.new
# Assets2IIF.depreciate_assets(assets, 2009, 2009)
# Assets2IIF.depreciate_assets(assets, 2010, 2010)
# Assets2IIF.depreciate_assets(assets, 2011, 2011)
# Assets2IIF.depreciate_assets(assets, 2012, 2012)
# Assets2IIF.depreciate_assets(assets, 2013, 2013)

# assets[:MYASSET].sold_date = nil
# Assets2IIF.depreciate_assets(assets, 2009, 2020)
