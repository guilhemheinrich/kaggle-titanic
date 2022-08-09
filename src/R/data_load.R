training <- read.csv("../../data/train.csv")
test <- read.csv("../../data/test.csv")

#    ______            _      _                          _   
#   |  ____|          (_)    | |                        | |  
#   | |__   _ __  _ __ _  ___| |__  _ __ ___   ___ _ __ | |_ 
#   |  __| | '_ \| '__| |/ __| '_ \| '_ ` _ \ / _ \ '_ \| __|
#   | |____| | | | |  | | (__| | | | | | | | |  __/ | | | |_ 
#   |______|_| |_|_|  |_|\___|_| |_|_| |_| |_|\___|_| |_|\__|
#                                                            
#                                               
training[["Sex"]] <- as.factor(training[["Sex"]])
training[["Embarked"]] <- as.factor(training[["Embarked"]])
training[["Survived"]] <- as.factor(training[["Survived"]])

test[["Sex"]] <- as.factor(test[["Sex"]])
test[["Embarked"]] <- as.factor(test[["Embarked"]])

