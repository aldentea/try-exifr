require 'exifr'
require 'exifr/jpeg'


class PhotoFile
	attr_accessor :filename
	attr_accessor :lat
	attr_accessor :long

	def initialize(filename)
		exif = EXIFR::JPEG.new(filename)
		if exif.exif?
			@lat = exif.gps.latitude
			@long = exif.gps.longitude
			@filename = filename
		end
	end

	# とりあえず，手抜き実装しておく．
	def distance(photofile)
		(photofile.lat - @lat).abs + (photofile.long - @long).abs
	end

end
