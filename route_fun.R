#Functions and libraries called by route.R

library(httr)
library(rjson)

#Send pairs of co-ordinates to local openrouteservice server
get_route_dist <- function(lat1, lon1, lat2, lon2){

url <- paste0('http://localhost:8080/ors/v2/directions/driving-car?start=',
              lon1,
              ',',
              lat1,
              '&end=',
              lon2, 
              ',',
              lat2)

res <- GET(url,
           add_headers(accept='application/json')
           )

r <- fromJSON(content(res, 'text', encoding = 'UTF-8'))

if(is.null(r$features[[1]]$properties$segments[[1]]$distance)){
  distance <- 1000000
}else{
 distance <- r$features[[1]]$properties$segments[[1]]$distance
}
print(distance)
return(distance)
}

#Compares start co-ordrinates to all points in data frame of co-ordinates
#Calls get_route_dist
one_step <- function(lat1, lon1, destination){
  
  one_step_mat <- matrix(data=0, nrow=nrow(destination), ncol=2)
  
  one_step_df <- as.data.frame(one_step_mat)
  
  for(i in 1:nrow(destination)){
    
    one_end_lon <- destination[i,2]
    one_end_lat <- destination[i,3]
    
    
    distance <- get_route_dist(lat1 = lat1,
                               lon1 = lon1,
                               lat2 = one_end_lat, 
                               lon2 = one_end_lon
    )
 
    one_step_df[i,1] <- as.character(destination[i, 1])
    one_step_df[i,2] <- distance
  }
  colnames(one_step_df) <- c("address", "distance")
  return(one_step_df)
}






#Old function: uses here.com API for route finding
next_loc <- function(start, end){
  
  begin <-  geocode(start,
                    autocomplete = FALSE, sf = TRUE, url_only = FALSE)
  
  finish <- geocode(end,
                    autocomplete = FALSE, sf = TRUE, url_only = FALSE)
  
  res <- route(origin = begin,
               destination = finish,
               mode = "car",
               type="fastest")
  
  addr_dist <- data.frame("address"=end, 
                          "distance"=res$distance
  )
  
  return(addr_dist)
}
