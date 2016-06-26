require 'open-uri'
require 'pdf-reader'
require 'pry'

class PdfParser
  attr_reader :hash
  def initialize(uri)
    @uri = uri
    @pdf = open(@uri)
    @reader = PDF::Reader.new(@pdf)
    @page = @reader.page(1)
    @lines = @page.text.split(/\n/)
    @hash = {}

    match_lines
    @hash
  end

  def match_lines
    @trains = []
    @times = []

    @lines[0..25].each do |line|
      @times = nil

      @trains = line.scan(/\b(\d{3})\b/) if @trains.empty? #filter out non-coaster trains later
      @times = line.scan(/(\d+:\d+[a||p])/)
      hashify_schedule unless @trains.empty? || @times.empty?
    end
  end

  def hashify_schedule
    @trains.each_with_index do |train, index|
      @hash[train[0].to_i] ||= []
      @hash[train[0].to_i] << @times[index][0]
    end
  end

  def coaster_only
    coaster = @hash.reject {|k, v| k.to_s =~ /\b7\d+\b/ }
  end
end

@parsed = PdfParser.new('http://www.gonctd.com/wp-content/uploads/Schedules/Coaster-Schedule.pdf')

# @hash={630=>["5:12a", "5:16a", "5:21a", "5:27a", "5:32a", "5:41a", "6:01a", "6:10a"],
#        634=>["6:01a", "6:05a", "6:10a", "6:15a", "6:20a", "6:29a", "6:55a", "7:02a"],
#        636=>["6:49a", "6:54a", "6:59a", "7:05a", "7:13a", "7:22a", "7:46a", "7:53a"],
#        638=>["7:13a", "7:17a", "7:23a", "7:28a", "7:36a", "7:46a", "8:10a", "8:17a"],
#        640=>["7:42a", "7:46a", "7:51a", "7:57a", "8:02a", "8:14a", "8:37a", "8:45a"],
#        644=>["9:43a", "9:48a", "9:53a", "9:59a", "10:07a", "10:16a", "10:38a", "10:47a"],
#        648=>["11:08a", "11:13a", "11:18a", "11:24a", "11:32a", "11:41a", "12:07p", "12:14p"],
#        654=>["2:42p", "2:47p", "2:52p", "3:00p", "3:05p", "3:14p", "3:36p", "3:44p"],
#        656=>["3:32p", "3:36p", "3:43p", "3:49p", "3:54p", "4:03p", "4:28p", "4:35p"],
#        660=>["5:12p", "5:17p", "5:22p", "5:28p", "5:35p", "5:44p", "6:08p", "6:16p"],
#        662=>["5:41p", "5:46p", "5:51p", "5:56p", "6:01p", "6:11p", "6:37p", "6:45p"],
#        784=>["7:03p", "7:08p", "7:14p", "7:23p", "7:29p", "7:39p", "8:02p", "8:09p"],
#        790=>["9:20p", "9:25p", "9:32p", "9:40p", "9:47p", "9:57p", "10:20p", "10:30p"],
#        796=>["11:57p", "12:03a", "12:12a", "12:19a", "12:26a", "12:36a", "12:59a", "1:06a"],
#        664=>["6:42p", "6:48p", "6:53p", "6:59p", "7:05p", "7:15p", "7:42p", "7:50p"],
#        672=>["9:51p", "9:56p", "10:01p", "10:07p", "10:13p", "10:22p", "10:43p", "10:51p"]}
