# CSN-291 Project: Cookbait (A recipe finder app)
# IIT Roorkee CSE

## App Idea : 
This is an android application which helps you find suitable recipe from a set of suggestions recommended by us with help of available ingredients.

##Tech Stack :
We have used flutter(dart) with firebase(for database).
There are two dart files for each screen, one for the front end and second for writing the function that fetches the data from firebase. 

##Database :
There are three collections in our database which are as follows 
## Ingredients : Includes all the ingredients used in our list of recipes. 
## Recipes : Includes over 6000 recipes with image link, preparation time, list of ingredients, procedure etc.
## Comments : includes all the comments on various Recipes with document ID same as the document ID of that particular recipe to make it easy for fetching. 

The app flow is as follows : —
- On opening the app, the user is directed to a welcome page which describes the functionality of the app in brief. 
- Then the user is redirected to an ingredients page where the user can either search for an ingredient in our database or select some from the drop down list. 
- On clicking search, the app searches through a database of over 6,000 recipes to find the ones which have the maximum matching ingredients and suggests them to the user.
- On clicking on any particular recipe, the user is redirected to an individual recipe page which fetches the various details of that particular recipe and displays them to the user.
- After preparing the recipe the users can also write comments that will help other users.
