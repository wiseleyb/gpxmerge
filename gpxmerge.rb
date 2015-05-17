class GpxMerge
  require 'rubygems'
  require 'nokogiri'

  # GpsMerge.merge(['data/file1.gpx', 'data/file2.gpx'], 'data/output.gpx', true)
  def self.merge(files, output, delete_names = false)
    res = ['<gpx>']
    Array(files).each do |fname|
      f = File.open(fname)
      doc = Nokogiri::XML(f)
      doc.xpath('//xmlns:name').remove if delete_names
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
end
