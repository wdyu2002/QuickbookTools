

class AssetLoader

	# static assets list.
  # class << self; attr_accessor :assets end
	# @assets = {}

	def self.load(assets_dir)
		# use hash to ensure uniqueness. although it is more
		# useful if assets was a static field. since it's
		# easy enough to retrieve values from the hash, there's
		# really no reason to use an array.
		assets = {}

		Dir[ assets_dir + '/*.rb' ].each do |file|
			# require/load file.
			require file

			# load class & append to assets array.
			cls_name = 'Asset_' + File.basename(file, '.rb')
			assets[cls_name] = Object.const_get(cls_name).new
		end

		# debug.
		puts 'AssetLoader: Total assets loaded: ' + assets.values.length.to_s

		# return loaded assets.
		assets
	end

end
