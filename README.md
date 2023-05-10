# OtakuBeats

## Table of Contents
1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [API Documentation/Reference](#API-Documentation-and-Reference)

## Overview
### Description
OtakuBeats is an app that allows users to find and listen to anime songs based on the anime they search for. Users can upload YouTube links of anime soundtracks, and the app will use the Kitsu API for anime searching and details, and YouTube API for embedded video playback. The app aims to create a central platform for anime music enthusiasts to discover, share, and enjoy their favorite anime songs.

### App Evaluation
- **Category:** Entertainment / Music
- **Mobile:** This app would be primarily developed for iOS mobile devices, making it convenient for users to access and listen to anime songs on-the-go or while engaging in other activities.
- **Story:** Utilizes the Kitsu API to help users search for anime titles and view their details, while the YouTube API enables embedded video playback of uploaded anime soundtracks. Users can explore songs based on filters like genre, type, and length.
- **Market:** The primary target audience for this app would be anime and music enthusiasts who are interested in discovering, sharing, and enjoying anime soundtracks. The app could cater to a wide range of users, from casual anime viewers to dedicated fans.
- **Habit:** Users would engage with the app regularly to discover new anime soundtracks, manage their favorite songs, and contribute by uploading YouTube links. The frequency of use could vary depending on the user's anime and music interests.
- **Scope:** The initial version of OtakuBeats would focus on key features such as anime search, soundtrack playback, user authentication, and song uploading. Future expansions could include user-curated playlists, social sharing features, integration with other music streaming services, and personalized recommendations.

## Product Spec
### User Stories (Required and Optional)

**Required Must-have Stories**
* Users can search for anime titles using the Kitsu API and view their details.
* Users can listen to embedded YouTube videos of anime soundtracks associated with the searched anime.
* Users can filter anime soundtracks by genre, type, and length.
* Users can register for an account and log in to access personalized features and save their preferences.
* Users can upload YouTube links of anime soundtracks and specify their type and genre.

**Optional Nice-to-have Stories**
* Users can create playlists of their favorite anime soundtracks.
* Users can share their favorite soundtracks or playlists with others via social media, email, messaging apps, etc.
* Integration with other music streaming services like Spotify and Apple Music.
* Personalized recommendations based on the user's listening history and preferences.

### 2. Screen Archetypes
- Registration
- Login
- Home
- Settings
    - Profile Settings
- Search
- Anime Details
- Soundtrack Playback
- Upload Soundtrack

### 3. Navigation

Tab Navigation (Tab to Screen)
- Home
- Search
- Upload Soundtrack
- Settings
- 
Flow Navigation (Screen to Screen)
- Home (no forced login)
- Anime Details -> Soundtrack Playback
- Search -> Filtered Search
- Upload Soundtrack (creating) -> Register/Login if needed -> Soundtrack Upload
- Settings -> Toggle Settings
- Soundtrack Playback -> Full Screen Video

## API Documentation and Reference
- https://developers.google.com/youtube/v3/
- https://kitsu.docs.apiary.io/#
