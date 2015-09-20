class GpxMerge
  require 'rubygems'
  require 'nokogiri'

  # GpsMerge.merge('data', 'data/output.gpx')
  # files: filename or an array of files or a path name (which will find *.gpx)
  # output: filename for results
  # days: a day or an array of days to filter on in format 'YYYY-MM-DD' or a
  #   Range of days ('2015-01-10'..'2015-01-15')
  # options:
  #   keep_name: false (default) remove track names... this can really clutter up Google Earth
  #   keep_waypoints: false (default)  waypoints (xmlns:wpt) will be removed
  def self.merge(files, output, days, options = {})
    keep_names = options[:keep_names]
    keep_waypoints = options[:keep_waypoints]

    days = Array(days).keep_if { |day| day.split('-').last.to_i <= 31 }

    file_names =
      if File.directory?(files)
        Dir[File.join(files, '*.gpx')]
      else
        Array(files)
      end

    res = ['<gpx>']

    file_names.each do |fname|
      puts "Processing: #{fname}"
      f = File.open(fname)
      doc = Nokogiri::XML(f)

      # remove name nodes
      doc.xpath('//xmlns:name').remove unless keep_names

      # remove way points
      doc.xpath('//xmlns:wpt').remove unless keep_waypoints

      # remove days that don't match criteria
      unless days.empty?
        doc.xpath('//xmlns:trkpt').each do |trkpt|
          unless (days.any? { |day| trkpt.to_s.include?(day) })
            trkpt.remove
          end
        end
        # I tried to get something like to work but it was returning incorrect
        # results. The above code is WAY slower though... so if you're
        # processing a ridiculous amount of data with this frequently you might
        # want to try to figure it out :) I use this code a few times a year so
        # it doesn't much matter to me.
        #
        # doc.xpath(
        #   "//xmlns:trkpt[xmlns:time[not(text()[#{xpath_contains(Array(days))}])]]"
        # ).remove
      end

      # remove empty tracks
      doc.xpath("//xmlns:trk[xmlns:trkseg[not(xmlns:trkpt)]]").remove

      res << doc.xpath('//xmlns:trk').to_s
      f.close
    end
    res << '</gpx>'
    f = File.open(output, 'w')
    f.write res.join
    f.close
  end

  # takes an array (arr) and converts it to
  #   contains(.,arr[0]) or contains(.,arr[1]) ... etc
  def self.xpath_contains(arr)
    arr.map { |a| "contains(.,'#{a}')" }.join(' or ')
  end
end
