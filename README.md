# GpxMerge

This is a simple Ruby utility to merge multiple .gpx files into one. 

Use case (hasn't been tested on anything else): I have a Garmin Zumo 660. If you connect the device to your computer, open it's drive and go to /garmin/GPX - you'll see GPX files. Copy those to your computer and use this code to merge them. I used this to upload all my motorcycle rides over the past 3 years to Google Earth (just File -> Open -> the-gpx-file).

## How to

	git clone https://github.com/wiseleyb/gpxmerge
	cd gpxmerge
	gem install nokogiri
	irb
	> include './gpxmerge.rb'
	> GpxMerge.merge_all_gpx_files('data', 'output.gpx', true)

The "true" option removes the `<name>` element from the output. This can be pretty annoying in Google Earth if you have a lot of data.

More GPX data is available at [https://github.com/wiseleyb/gps-data](https://github.com/wiseleyb/gps-data) if you want something to play around with.

Pull requests welcome.

<img src='https://raw.githubusercontent.com/wiseleyb/gpxmerge/master/sample.png'/>