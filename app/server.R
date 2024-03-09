library(shiny)
library(jsonlite)
library(httr2)

df_questions <- dkuReadDataset("quiz_demo", samplingMethod="head", nbRows=100000)

chat <- function(body) {
    user_message <- list(list(role = "user", content = message))
    base_url <- "https://api.openai.com/v1"
    api_key <- "<add-openai-api-key>"
    req <- request(base_url)
    resp <-
        req |> 
        req_url_path_append("chat/completions") |> 
        req_auth_bearer_token(token = api_key) |> 
        req_headers("Content-Type" = "application/json") |> 
        req_user_agent("Lynnaj | Test R interface") |> 
        req_body_json(body) |> 
        req_retry(max_tries = 4) |> 
        req_throttle(rate = 15) |> 
        req_perform()
    openai_chat_response <- resp |> resp_body_json(simplifyVector = TRUE)
    openai_chat_response$choices$message$content
}

character_image <- function(character) {
    prefix = "https://customsearch.googleapis.com/customsearch/v1?cx=801ec74cad7f94243&imgSize=SMALL&q="
    search_q = gsub(" ", "%20", character)
    suffix = "&safe=active&key=<add-google-api-key>"
    query = paste(prefix, search_q, suffix, sep = "")
    results <- 
        request(query) |>
        req_perform()
    google_response <- results |> resp_body_json()
    image_link_1 <- google_response$items[[1]][[11]]$metatags[[1]]$'og:image'
    image_link_2 <- google_response$items[[2]][[11]]$metatags[[1]]$'og:image'
    image_link <- ifelse(is.null(image_link_1), image_link_2, image_link_1)
    image_link
}

server <- function(input, output, session) {
    renderSurvey()
    
    observeEvent(input$submit, {  
        df <- getSurveyData()
        questions <- unique(df_questions$question)
        answers <- df$response
        print(questions)
        print(answers)
        
        body_text_response <- list(
            model = "gpt-3.5-turbo",
            messages = list(
                list(role = "system", content = "You are an expert on giving insightful career advice.  You are also funny and charming.  
                        Compare the user to a famous TV or movies character. For example, characters like:
                        Michael Scott from 'The Office' for being a Social Butterfly,
                        Leslie Knope from 'Parks and Recreation' for being a perfectionist, 
                        Liz Lemon from '30 Rock' for being a Free Spirit, 
                        Sheldon Cooper from 'The Big Bang Theory' for being an Innovator.
                        Only make 2 comparisons to the chosen character.  Give insightful career advice.  Limit your response to 5 sentences."),
                list(role = "user", content = paste("I just took a quiz about my career archetype. Give me insightful career advice and compare me to a popular TV or movie character. Here are the questions: 
                        ", toString(questions) ,"And here are my answers respectively: ", toString(answers)))
    # Ensure no empty arguments are passed here
          )
        )
      
        text_response <- chat(body_text_response)
        
        print(text_response)
        
        body_image_response <- list(
            model = "gpt-3.5-turbo",
            messages = list(
                list(role = "system", content = "You are a filter for the famous TV or movies character name"),
                list(role = "user", content = paste("Below is the text the should include a name of a famous personality.  
                Filter and respond with the full name.  No other descriptions, words, or introduction.
                Here is the text: ", text_response))
    # Ensure no empty arguments are passed here
          )
        )
        
        name_response <- chat(body_image_response)
        print(name_response)
        
        link <- character_image(name_response)
        print(link)
        
        base = '<img src="https://as2.ftcdn.net/v2/jpg/01/59/07/19/1000_F_159071974_fHQ1UzIy4oDeTSgpjZaChMQcbJIiTYqz.jpg">'
        print(base)
        
        image_html <- gsub('src="[^"]*"', paste0('src="', link, '"'), base)
        print(image_html)
        
        showModal(modalDialog(
          title = paste("Congrats, you're like", name_response , "!"),
          HTML(image_html),
          br(),
          text_response
        ))
         
  })
}
