# Movies
![movie1](https://user-images.githubusercontent.com/19923951/53302215-d1d82800-3864-11e9-87d4-068f6f8d3497.png)
![movie2](https://user-images.githubusercontent.com/19923951/53302217-e6b4bb80-3864-11e9-9312-08d48ff5acf3.png)
![movie3](https://user-images.githubusercontent.com/19923951/53302230-03e98a00-3865-11e9-8e63-561339724042.png)

Overview
=======
    iPhone application that has a displays list of movies from the internet
    and allow the user to add movies of their own.
    
Project Description
===============
    ● User should see a list of movies when he start the app with section title “All Movies”
    ○ User should see for each movies entry: Title, overview, date and poster
    ● User should be able to load new pages as he scrolls down to the last cell
    ○ User should see a loading indicator at the bottom if the new page isn’t available
    yet
    ● User should be able to add a new movie of his own to the app
    ○ User should be able to set the Title, overview, date and Image for his movie
    ■ User should be able to set the image for this movie from gallery
    ● User should be able to see his new added movies in a new section at the top with title
    “My Movies”

Project Design
============
Project consist of 4 main parts:
1- apis

    to make the connection with the server to get data and download image from url.
2- model

    the model of our data that we are dealing with, is this case movie struct and types.
3- views

    contain the main storyboard, external features supported to UITextView(support placeholder) and UIButton(support closure action inside the same block) and full programatically file to create add new movie view(it can be done using xlib or new view controller in the storyboard but here I code it to show different way to get to the target).
4- controllers

    our controller that deal with api and our model to show it in our ui.

Notes
=====
● I'm do not use any third party libraries
