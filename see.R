### this is a bad script!
# don't just run it, it has interactive bits!


library(stringr)
library(png)
library(knitr)



# load the local locations of the images
files <- list.files("screens", ".png", full.names=TRUE)

# make some table storage
nd <- data.frame(name=files, intoit=NA)

# this cycles through all the images prompting the user about each
for(i in seq_along(files)){
  plot(0:1, 0:1, type="n", main=files[i])
  p <- readPNG(files[i])

  # some of the images are somehow broken for rasterImage so add another
  # 2 colour channels?
  if(dim(p)[3] < 3){
    p <- abind::abind(p, array(1, replace(dim(p), 2, 500)), along=3)
  }

  # the old plot and prompt
  rasterImage(p, 0,0,1,1)
  nd$caption[i] <- readline("Caption: ")
}

# save that
saveRDS(nd, file="curtis-captions.rds")

write.csv(nd, file="curtis-captions.csv")



