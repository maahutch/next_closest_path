library(hereR)

paths <- read.csv('file_paths.csv',header = F)

places <- paths[1,2]

key <- paths[2,2]

set_key(key[1,1])

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

  
  
one_step <- function(start, destination){
  
  one_step_mat <- matrix(data=0, nrow=length(destination), ncol=2)
  
  one_step_df <- as.data.frame(one_step_mat)
  
  for(i in 1:length(destination)){
    
    one_end <- destination[i]
    distance <- next_loc(start = start,
                         end = one_end)  
    
    one_step_df[i,1] <- distance[1,1]
    one_step_df[i,2] <- distance[1,2]
  }
  colnames(one_step_df) <- c("address", "distance")
  return(one_step_df)
}


addresses <- as.vector(places$Address)

current_path <- data.frame("address"= places$Address[1], 
                           "distance"=100000,
                           "name"=places$Name[1],
                           "phone"=places$Phone[1])

for(i in addresses){
      
  begin <- tail(current_path$address, n=1) 
      
  addresses2 <- addresses[!addresses %in% current_path$address]

  all_next_paths <- one_step(start       = begin, 
                             destination = addresses2)
        
  next_step <- all_next_paths[which.min(all_next_paths$distance), ]
  
  name_phone <- places[which(places$Address == next_step$address[1]), ]
  
  next_step <- cbind(next_step, name_phone$Name, name_phone$Phone)
  
  colnames(next_step) <- c("address", "distance", "name", "phone")
   
  current_path <- rbind(current_path, next_step)

  }
  
write.csv(current_path, paths[3,2])

