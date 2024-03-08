library(shiny)
library(shinysurveys)
library(dataiku)

df_questions <- dkuReadDataset("quiz_demo", samplingMethod="head", nbRows=100000)

ui <- fluidPage(
  shinysurveys::surveyOutput(df = df_questions,
                             survey_title = "Your Career Archetype",
                             survey_description = "Get insights about yourself!")
)


#https://shinysurveys.jdtrat.com/articles/surveying-shinysurveys.html
