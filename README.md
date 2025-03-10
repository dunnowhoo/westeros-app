# Westeros App

<img src="https://i.imgur.com/Ys0xU1l.png" alt="Westeros App Banner" style="max-width:100%;">

Westeros App is a mobile application dedicated to fans of **Game of Thrones**. Built with Flutter and Dart, this app brings together a range of exciting features so you can experience the world of Westeros right at your fingertips.


## Dependencies

This app uses several dependencies for API data fetching, local storage, and more. The main dependencies are:

- **cupertino_icons: ^1.0.8**  
  Standard iOS icons.
- **http: ^1.3.0**  
  For retrieving data from the TMDB API.
- **hive_flutter: ^1.1.0**  
  For local data persistence.


## Features

Westeros App offers an immersive experience for GOT fans with the following features:

- **Episode Listings & Details:** 
<p align="center">
  <img src="https://i.imgur.com/cX5hcmJ.jpeg" width="200" alt="Image 1">
  <img src="https://i.imgur.com/BkLwe01.jpeg" width="200" alt="Image 2">
  <img src="https://i.imgur.com/GEtEqXF.jpeg" width="200" alt="Image 3">
</p>

  - View episodes categorized by **Newest**, **Most Popular**, and by season.
  - Detailed episode pages feature an image carousel, along with information such as rating, runtime, air date, synopsis, and a list of guest stars.

- **House & Character Explorer:**  
<p align="center">
  <img src="https://i.imgur.com/97AfDhJ.jpeg" width="200" alt="Image 1">
  <img src="https://i.imgur.com/Z1z2BgA.jpeg" width="200" alt="Image 2">
</p>
  - Browse various houses such as House Stark, Lannister, Targaryen, and more.
  - Each house displays its unique sigil (logo) and inspiring words.
  - Explore the sworn members of each house with details like name, titles, TV series, and the actors who play them.

- **Favorites:**  
<p align="center">
  <img src="https://i.imgur.com/0dPsZAy.jpeg" width="200" alt="Image 1">
</p>
  - Mark your favorite episodes, which are stored locally using Hive.
  - The favorites list automatically refreshes when changes occur (e.g., when an episode is unfavorited).

- **About Me**  
<p align="center">
  <img src="https://i.imgur.com/nEJ1qzC.jpeg" width="200" alt="Image 1">
  <img src="https://i.imgur.com/pESiB3g.jpeg" width="200" alt="Image 2">
</p>


## How It Works

1. **Data Retrieval:**  
   - Episode data is fetched from the [TMDB API](https://www.themoviedb.org/documentation/api) and sorted by rating and air date.
   - House and character data is retrieved from [An API of Ice And Fire](https://anapioficeandfire.com/), which provides in-depth information about the GOT universe.

2. **Local Storage:**  
   - Hive is used to store favorite episodes locally so that your data remains available even after closing the app.

3. **User Interface:**  
   - A modern, interactive UI built with Flutter widgets such as PageView, ListTile, and custom cards.
   - A responsive design that stays true to the epic GOT atmosphere.


## What I Learned

During my last semester in my PBP class, I picked up the basics of Dart programming. But working on Westeros App really pushed me into the deep end of mobile app development. One of the coolest parts was diving into API integration. I learned how to pull in data from sources like the TMDB API and An API of Ice And Fire, which let me display dynamic, real-time content in the app. It wasn’t just about sending requests—it was about truly understanding RESTful services, handling asynchronous data, and gracefully managing errors.

Another game-changer was getting into local persistence. Implementing Hive for local storage turned out to be a lifesaver for keeping track of favorite episodes. Even if the app is closed, users’ favorite data sticks around, which really drove home the importance of state management and having a reliable way to cache data. UI/UX design was another major area of growth. I had a blast crafting a responsive, engaging user interface with Flutter. One highlight was building a carousel animation for the house cards (shoutout to the Wizarding World App by kak carlene lol). I also learned a lot about debugging and testing along the way. I ran into issues like data type casting errors with Hive and asset loading problems, which forced me to improve my troubleshooting skills and think more systematically when things went wrong.

All in all, working on Westeros App wasn’t just about applying what I already knew—it was about leveling up my skills in API integration, local storage with Hive, and UI/UX design. My App might not be perfect, but I learned a ton from the project. It’s been an exciting journey full of challenges and valuable learning experiences, and I’m excited to keep exploring the world of mobile development.
