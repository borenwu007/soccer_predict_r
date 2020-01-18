library(goalmodel)
library(dplyr) # Useful for data manipulation. 
library("rjson")
library(stringr)



#* Return the predict of two teams
#* @param leagure The leagure name
#* @param team_h The home team
#* @param team_a The away team
#* @post /predict
predict <- function(leagure, team_h, team_a) {
    setwd("E:\\code\\R\\soccer_predict")
    
    if(str_detect(team_h, "20%")) {
        team_h <- str_replace(team_h,"20%"," ")
    }
    
    if(str_detect(team_a, "20%")) {
        team_a <- str_replace(team_a,"20%"," ")
    }
    
    result <- fromJSON(file = "config.json")
    filename <- result[[leagure]][['file']]
    soccer_record <- read.csv(filename)
    
    goals1 <- soccer_record$FTHG
    goals2 <- soccer_record$FTAG
    team1 <- soccer_record$HomeTeam
    team2 <- soccer_record$AwayTeam

    gm_res <- goalmodel(goals1 = goals1, goals2 = goals2,
                        team1 = team1, team2=team2,
                        dc=TRUE
                      )
    
    
    print(team_h)
    print(team_a)
    to_predict1 <- c(team_h)
    to_predict2 <- c(team_a)

    predict_goals <- predict_expg(gm_res, team1=to_predict1, team2=to_predict2, return_df = TRUE)
    predict_result <- predict_result(gm_res, team1=to_predict1, team2=to_predict2, return_df = TRUE)

    
    df2 = data.frame(
        team_name = c(predict_goals$team1, "DRAW", predict_goals$team2), 
        exp_goals = c(predict_goals$expg1, "NA", predict_goals$expg2),
        exp_result = c(predict_result$p1, predict_result$pd, predict_result$p2)
    )

    return(df2)

}