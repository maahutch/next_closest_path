#Sorts data frame of geocoded addresses into single route

#Load functions and libraries
source('/home/maahutch/next_closest_path/route_fun.R')

#Read file paths 
paths <- read.csv('/home/maahutch/next_closest_path/file_paths.csv',header = F)

#Read geocoded data
places_path <- as.character(paths[1,2])

places <- read.csv(places_path,
                   header = F
                   )



addresses <- data.frame('text' = places$V15,
                        'lon'  = places$V16,
                        'lat'  = places$V17)


places$Name <- paste(places$V3, places$V4, places$V2, sep = ' ')

###############################################################################
#If the process gets interrupted, uncomment this section to read the incomplete
#file as the current_path and resume process. 
###############################################################################

# done <- read.csv(paste0(paths[3,2], '/new_albany.csv'),
#                          header = T)

# current_path <- data.frame("address"= done$address, 
#                            "distance"=done$distance,
#                            "name"=done$name,
#                            "lon" = done$lon,
#                            "lat"= done$lat)
# 
# current_path <- current_path[-nrow(current_path),]

###############################################################################
###############################################################################

#Assigns starting location as first row from raw data file
current_path <- data.frame("address"= places$V15[1],
                          "distance"=100000,
                          "name"=places$Name[1],
                          "lon" = places$V16[1],
                          "lat"=places$V17[1])


for(i in 1:nrow(addresses)){
  
  lon1 <- tail(current_path$lon, n=1) 
  lat1 <- tail(current_path$lat, n=1) 
      
  addresses2 <- addresses[!(addresses$text %in% current_path$address),]

  all_next_paths <- one_step(lat1 = lat1,
                             lon1 = lon1,
                             destination = addresses2)
        
  next_step <- all_next_paths[which.min(all_next_paths$distance), ]
  
  name_phone <- places[which(places$V15 == next_step$address[1]), ]
  
  next_step <- cbind(next_step, name_phone$Name, name_phone$V16, name_phone$V17)
  
  colnames(next_step) <- c("address", "distance", "name", "lon", "lat")
   
  current_path <- rbind(current_path, next_step)
  
  #Set name of your output file here
  output <- paste0(paths[3,2], '/franklin_greenwood.csv')  
  
  write.csv(current_path, output)

  }



