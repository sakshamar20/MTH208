
MontyHall <- function(num_simulations = 1000) {
  # Initialize a variable to count the number of wins
  wins <- 0
  
  for (i in 1:num_simulations) {
    # Simulate the contestant's initial choice
    contestant_choice <- sample(1:3, 1)
    
    # Simulate the location of the car behind the doors
    car_location <- sample(1:3, 1)
    
    # Determine which door the host opens (not the contestant's choice and not the car)
    host_opens <- sample(1:3, 1)
    while (host_opens == contestant_choice || host_opens == car_location) {
      host_opens <- sample(1:3, 1)
    }
    
    # Determine the door the contestant switches to (not the host's choice or the initial choice)
    switch_to <- sample(1:3, 1)
    while (switch_to == host_opens || switch_to == contestant_choice) {
      switch_to <- sample(1:3, 1)
    }
    
    # Check if the contestant wins (car is behind the switched door)
    if (switch_to == car_location) {
      wins <- wins + 1
    }
  }
  
  # Calculate the proportion of wins
  win_proportion <- wins / num_simulations
  
  return(win_proportion)
}

# Example usage:
set.seed(123)  # Set a seed for reproducibility
result <- MontyHall(100000)
cat("Proportion of wins:", result, "\n")


