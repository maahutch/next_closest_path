# next_closest_path
This application accepts an unsorted list of text address and returns a sorted 
list based a 'next closest neighbor' algorithm. The code assumes the starting 
location is the first row of the input data. Each subsequent address is compared
to that starting location to find which is the closest based on driving 
distance. The starting location is then replaced by whichever address is closest
and the process repeats to find the next closest address.  

As written, the code assumes the input file has the following columns: 

"Row Number", "Last Name", "First Name", "Middle Name", "Suffix", "Tel. No.", 
"Street Address", "City", "State", "5 digit Zip", "Zip +4", "County", "Email",
"Precinct", "Full Address", "Longitude", "Latitude"

This application requires an Open Route Service server running on the localhost 
with a .pbf file for the area that contains the addresses. Instructions on 
setting up the routing server can be found on the [GIScience Research group github repo](https://github.com/GIScience/openrouteservice). The .pbf mapping files 
can be downloaded from [GeoFrabrik](http://download.geofabrik.de/)

The sorted list will be exported to the path (including file name) in the 
'file_paths.csv' in the 'output' row. 