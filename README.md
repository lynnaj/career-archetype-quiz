# ShinyR Web App for Generative AI POC

This project is a Shiny R web application designed to demonstrate the use case of generative AI through a Proof of Concept (POC). It leverages the ShinySurveys and httr2 packages for building interactive surveys and making HTTP requests, respectively. Additionally, it integrates with OpenAI's API and Google Search API to showcase generative AI capabilities.

## Features

- **Interactive Surveys**: Utilizes ShinySurveys package to create engaging and interactive surveys for users.
- **HTTP Requests**: Employs httr2 package for making HTTP requests to external APIs seamlessly.
- **Generative AI Integration**: Demonstrates the use of OpenAI's API for generative AI responses.
- **Google Search API Integration**: Incorporates Google Search API for relevant search results within the application.

## Setup and Installation

1. **Clone the Repository**: Clone this repository to your local machine.
2. **Install Dependencies**: Make sure you have R and the required packages installed. You can install the necessary packages by running the following command in R:

```R
install.packages(c("shiny", "shinysurveys", "httr2"))


Certainly! Here's a simple README.md for your Shiny R web app project:

markdown
Copy code
# ShinyR Web App for Generative AI POC

This project is a Shiny R web application designed to demonstrate the use case of generative AI through a Proof of Concept (POC). It leverages the ShinySurveys and httr2 packages for building interactive surveys and making HTTP requests, respectively. Additionally, it integrates with OpenAI's API and Google Search API to showcase generative AI capabilities.

## Features

- **Interactive Surveys**: Utilizes ShinySurveys package to create engaging and interactive surveys for users.
- **HTTP Requests**: Employs httr2 package for making HTTP requests to external APIs seamlessly.
- **Generative AI Integration**: Demonstrates the use of OpenAI's API for generative AI responses.
- **Google Search API Integration**: Incorporates Google Search API for relevant search results within the application.

## Setup and Installation

1. **Clone the Repository**: Clone this repository to your local machine.

git clone https://github.com/your-username/shinyr-generative-ai-poc.git

css
Copy code

2. **Install Dependencies**: Make sure you have R and the required packages installed. You can install the necessary packages by running the following command in R:

```R
install.packages(c("shiny", "shinysurveys", "httr2"))
API Configuration: Obtain API keys for OpenAI and Google Search API. Replace the placeholder API keys in the app.R file with your actual API keys.

Run the Application: Navigate to the project directory and run the Shiny app.

R
Copy code
runApp()
Access the Application: Once the app is running, open your web browser and go to http://localhost:port (replace port with the port number specified in the R console).

