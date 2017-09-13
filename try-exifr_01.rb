require 'exifr'
require 'exifr/jpeg'

# あるディレクトリの全てのJPGファイルに対して，その位置を列挙する．
dir = ARGV.shift

if dir && Dir.exist?(dir)

	Dir.chdir(dir)

	# 大文字と小文字の違いは無視される．(ファイルシステム依存？)
	Dir.glob("*.{jpg}").each do |file|
		exif = EXIFR::JPEG.new(file)
		if exif.exif?
			puts "#{file}, #{sprintf("%.4f", exif.gps.latitude)}, #{sprintf("%.4f", exif.gps.longitude)}"
		end
	end
else
	puts "引数にディレクトリ名を指定して下さい．"
end
