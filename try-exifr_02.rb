

require_relative 'photo-file'

# 指定したファイルに"近い"位置で撮影された順に，同じディレクトリにあるファイルを列挙する．
origin_file = ARGV.shift
origin = PhotoFile.new(origin_file)


dir = File.dirname(origin_file)
friends = []

if dir && Dir.exist?(dir)

	Dir.chdir(dir)

	# 大文字と小文字の違いは無視される．(ファイルシステム依存？)
	Dir.glob("*.{jpg}").each do |file|
		friends << PhotoFile.new(file)
	end
end

friends.map! { |photo| [photo, origin.distance(photo)] }
friends.sort_by! { |item| item[1] }
friends.each do |item|
	puts "#{item[0].filename}, #{sprintf("%.4f", item[0].lat)}, #{sprintf("%.4f", item[0].long)}, #{sprintf("%.4f", item[1])}"
end
