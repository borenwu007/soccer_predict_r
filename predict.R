library(goalmodel)
library(dplyr) # Useful for data manipulation. 

# soccer_record <- read.csv('I1_2019_2020.csv')
# goals1 <- soccer_record$FTHG
# goals2 <- soccer_record$FTAG
# team1 <- soccer_record$HomeTeam
# team2 <- soccer_record$AwayTeam

# # Fit the default model, with the home team as team1.
# gm_res <- goalmodel(goals1 = goals1, goals2 = goals2,
#                      team1 = team1, team2=team2,
#                      dc=TRUE
#                      )

# # Show the estimated attack and defense ratings and more.
# summary(gm_res)

# to_predict1 <- c('Inter')
# to_predict2 <- c('Atalanta')

# predict_goals <- predict_expg(gm_res, team1=to_predict1, team2=to_predict2, return_df = TRUE)
# predict_result <- predict_result(gm_res, team1=to_predict1, team2=to_predict2, return_df = TRUE)

# print(predict_goals)
# print('----------------------------------')
# print(predict_result)

# # add weights
# my_weights <- weights_dc(soccer_record$Date, xi=0.0019)
# gm_res_w <- goalmodel(goals1 = goals1, goals2 = goals2, 
#                      team1 = team1, team2 = team2,
#                      weights = my_weights)


# predict_goals2 <- predict_expg(gm_res_w, team1=to_predict1, team2=to_predict2, return_df = TRUE)
# predict_result2 <- predict_result(gm_res_w, team1=to_predict1, team2=to_predict2, return_df = TRUE)

# print("##############################")
# print(predict_goals2)
# print('----------------------------------')
# print(predict_result2)


#* Return the predict of two teams
#* @param team_h The home team
#* @param team_a The away team
#* @post /predict
predict <- function(team_h, team_a) {
    soccer_record <- read.csv('I1_2019_2020.csv')
    goals1 <- soccer_record$FTHG
    goals2 <- soccer_record$FTAG
    team1 <- soccer_record$HomeTeam
    team2 <- soccer_record$AwayTeam

    gm_res <- goalmodel(goals1 = goals1, goals2 = goals2,
                        team1 = team1, team2=team2,
                        dc=TRUE
                     )
    
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