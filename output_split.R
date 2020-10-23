#Splits existing route file into equal pieces


paths <- read.csv('/home/maahutch/next_closest_path/file_paths.csv',header = F)

#Name of route file
done <- read.csv(paste0(paths[3,2], '/franklin_greenwood.csv'),
                 header = T)

#SNumber of segments required

no_segs <- 25

for(i in 1:(no_segs+1)){
  
  if(i == 1){
    start <- 1
  }else{
    start  <- (i-1)*58
  }
  
  if(i <= (no_segs)){
   end <- (i*58)-1
  }else{
   end <- (nrow(done))
  }
  
  
  output <- done[start:end,]
  
  #Output paths and file named - Incrementally numbered
  outpath <- paste0('/home/maahutch/output_paths/franklin_greenwood_split/franklin_greenwood_',
                    i,
                    '.csv')
  
  write.table(output, outpath, row.names=F, sep = ',')
  
}