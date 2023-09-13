library(imager)
dog <- load.image("dog.jpeg")
 dim(dog)
plot(dog)

graydog <- grayscale(dog)
dim(graydog)
plot(graydog)

# Extract the black and white image as matrix
gray.mat <- as.matrix(graydog[,,1,1])
dim(gray.mat)

# Extracts the array will all three rgb channels
col.mat <- as.array(dog[, ,1, ])
dim(col.mat)

# Vertical cropping
cropped.mat <- col.mat[1:300, , ]
crop.dog <- as.cimg(cropped.mat)
plot(crop.dog)

indices <-which(dog[,,1,2] == 1 & dog[,,1,1] == 0 & dog[,,1,3] == 0, arr.ind = TRUE)
points(indices, col = 'red', pch = 20)
plot(dog)

dog[,,1,1]=0
dog[,,1,3] = 0
plot(dog)
plot(as.cimg(as.matrix(dog[,,1,2])))
