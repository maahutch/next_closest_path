# next_closest_path
This scripts accepts an unsorted list of text address and returns a sorted list based a 'next closest neighbor' algorithm. The code assumes
the startign location is the first row of the input data. Each subsequent address is compared to that starting location to find which is the 
closest based on driving distance. The starting location is then replaced by whichever address is closest and the process repeats to find the 
next closest address.  

Address data should be in a csv file with the address data as a string a column title 'Address'. As written, the script expects a column 
called 'Name' and one called 'Phone'. Data in 'Name' and 'Phone' will be included in the output file. The location of the input file must
be added to 'file_paths.csv' file in the 'address' row. 

The script also requires an api key for the site [here.com](https://developer.here.com/). The script relies on the `hereR` library for geocoding,
so the user is required to obtain their own api key. The api key should be stored in a csv file called 'api_key.csv' and the path to this file 
added to the 'file_paths.csv' in the 'key' row. 

The sorted list will be exported to the path (including file name) in the 'file_paths.csv' in the 'output' row. 