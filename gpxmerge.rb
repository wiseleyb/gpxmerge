class GpxMerge
  require 'rubygems'
  require 'nokogiri'

  # GpsMerge.merge(['data/file1.gpx', 'data/file2.gpx'], 'data/output.gpx', true)
  # files: filename or an array of files
  # output: filename for results
  # delete_name: remove track names... this can really clutter up Google Earth
  # days: a day or an array of days to filter on in format 'YYYY-MM_DDDD'
  def self.merge(files, output, delete_names = false, days = nil)
    res = ['<gpx>']
    Array(files).each do |fname|
      f = File.open(fname)
      doc = Nokogiri::XML(f)

      # remove name nodes
      doc.xpath('//xmlns:name').remove if delete_names

      # remove days that don't match criteria
      unless Array(days).empty?
        doc.xpath(
          "//xmlns:trkpt[xmlns:time[not(text()[#{xpath_contains(Array(days))}])]]"
        ).remove
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

  # GpxMerge.merge_all_gpx_files('data', 'data/output.gpx', true)
  def self.merge_all_gpx_files(basedir, output, delete_names = false)
    merge(Dir[File.join(basedir, '*.gpx')], output, delete_names)
  end

  # takes an array (arr) and converts it to
  #   contains(.,arr[0]) or contains(.,arr[1]) ... etc
  def self.xpath_contains(arr)
    arr.map { |a| "contains(.,'#{a}')" }.join(' or ')
  end
end
