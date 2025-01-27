Cat Adoption App

Overview
* The application provides a seamless experience for listing adoption cats from an external API (https://cataas.com/api/cats). 
* It fetches data from the API and displays a list of available cats. When a cat is selected, users are directed to a detailed screen with further information about the chosen animal.
* In the event that the API is unavailable, a fallback mechanism is triggered to show mock data, ensuring uninterrupted functionality. 
* The project follows the MVVM (Model-View-ViewModel) architecture, promoting separation of concerns, testability, and maintainability. 
* Dependency Injection is also utilized to enhance flexibility and decouple the components.

![Project demonstration](assets/GravacaodetelaCatApi.gif)
   
Key Features
* MVVM Architecture: The app follows the MVVM design pattern, with the View layer being responsible for UI rendering, the ViewModel for managing app logic, and the Model representing the data layer.
* Fallback Mechanism: The app uses a fallback mechanism to show mock data when the API is unreachable, improving the user experience during service downtimes.
* Dependency Injection: Components like repositories and network services are injected into the app to allow for easy testing and reusability.
* Unit Testing: The app includes unit tests for key components, ensuring reliability and maintainability. 

Architecture
MVVM Design Pattern
* Model: Represents the data objects (e.g., Cat) and provides the structure for data fetching.
* View: The View layer is responsible for presenting data to the user. It is built using SwiftUI and binds to the ViewModel to update the UI dynamically.
* ViewModel: The ViewModel manages business logic and acts as the intermediary between the View and Model. It fetches data, handles errors, and formats data for the View to display. 

Dependency Injection
* Repositories are injected into the ViewModel during initialization, allowing for the flexibility of switching between real API calls and mock data without modifying the ViewModel's logic. The following dependencies are injected:
    * CatAPIRepository: A repository responsible for making network requests to the cataas.com API.
    * FallbackCatRepository: A repository that first tries to fetch data from the API, and if it fails, falls back to a local mock repository.
    * MockCatRepository: A repository that provides mock data, useful for testing and fallback scenarios. 

Error Handling and Fallback
* Fallback Strategy: If the API request fails or times out (after 10 seconds by default), the app switches to using the mock data repository to show a list of cats.  

Testing
* The app includes unit tests for the CatListViewModel, CatAPIRepository, and NetworkService, ensuring that the app functions correctly even in failure scenarios (e.g., API downtime, network issues).
* Test Scenarios:
    * Success: Verifies that data is fetched correctly and displayed in the UI.
    * Failure: Verifies that errors are handled gracefully, and fallback data is displayed when the API is down. 

Code Structure
* CatApp: The entry point of the app that initializes the dependencies and starts the main view (ContentView).
* ContentView: Displays the list of cats and handles the loading and error states.
* CatListView: Renders the list of cats fetched from the ViewModel.
* CatDetailView: Displays detailed information about a selected cat.
* CatListViewModel: The ViewModel responsible for fetching cat data and providing it to the View.
* CatRepository & NetworkServiceProtocol: Abstract the data fetching logic, making it easy to swap between real API calls and mock data.
  
Technologies Used
* SwiftUI: For building declarative UI.
* Kingfisher: For asynchronous image loading from URLs.
* XCTest: For writing unit tests.
