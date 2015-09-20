# GpxMerge

This is a simple Ruby utility to merge multiple .gpx files into one.

Use case (hasn't been tested on anything else): I have a Garmin Zumo 660. If you connect the device to your computer, open it's drive and go to /garmin/GPX - you'll see GPX files. Copy those to your computer and use this code to merge them. I used this to upload all my motorcycle rides over the past 3 years to Google Earth (just File -> Open -> the-gpx-file).

## How to

	git clone https://github.com/wiseleyb/gpxmerge
	cd gpxmerge
	gem install nokogiri
	irb
	> require './gpxmerge.rb'
	> GpxMerge.merge('data', 'output.gpx')

Merge has more options if you want...

        GpsMerge.merge('data', 'data/output.gpx')
        files: filename or an array of files or a path name (which will find *.gpx)
        output: filename for results
        days: a day or an array of days to filter on in format 'YYYY-MM-DD' or a
          Range of days ('2015-01-10'..'2015-01-15')
        options:
          keep_name: false (default) remove track names... this can really clutter up Google Earth
          keep_waypoints: false (default)  waypoints (xmlns:wpt) will be removed

See code for documentation.

More GPX data is available at [https://github.com/wiseleyb/gps-data](https://github.com/wiseleyb/gps-data) if you want something to play around with.

## Google Maps

Some sites that will import GPX data and show it on GoogleMaps

* [http://www.gpsvisualizer.com/](http://www.gpsvisualizer.com/)

You can also do this by:

* Upload your GPX to Google Earth
* Right click on the imported data and choose "Save Place As..." which allows you to export to a KML file
* Login to http [https://www.google.com/maps](https://www.google.com/maps)
* Open the top left hamburger menu (next to the search bar)
* Go to My Maps
* Create a new map and import the KML file
* This site has a really good explanation of dealing with GPX data [http://www.urbanhikr.com/how-to-import-gpx-into-google-maps/](http://www.urbanhikr.com/how-to-import-gpx-into-google-maps/)
* Example of GPS -> KML -> Google Maps [https://www.google.com/maps/d/viewer?mid=zYlk98UMNIvI.kIKBKJphN_MU&usp=sharing](https://www.google.com/maps/d/viewer?mid=zYlk98UMNIvI.kIKBKJphN_MU&usp=sharing)

Pull requests welcome.

<img src='https://raw.githubusercontent.com/wiseleyb/gpxmerge/master/sample.png'/>
