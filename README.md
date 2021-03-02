# PhotoGrid

PhotoGrid is a simple app to take your best photos organized. <br/>
You can check your prefered photos like favorites also.

## Features
  - Take a new photo using camera device 
    - or pick one from the the library photo if you need to use on a simulator for tests
  - See your photos on PhotoGrid's list
  - Tap photos in the list to see it larger
  - Users can mark a photo as a favorite to see it on PhotoGrid’s list on the top
  - Delete photo with a longpress. 
  - As PhotoGrid only displays it’s own photos, users can remove photos from the app and after that they choose to keep or remove from library too.


  Permissions              |  Add new photo <br/>(simulator only) |       Added PHotos      |       Detail View + Favorite     |    Removing a Photo
:-------------------------:|:------------------------------------:|:-----------------------:|:--------------------------------:|:--------------------------------:
:<img src="https://user-images.githubusercontent.com/29531/109706525-d2a0a480-7b77-11eb-90f7-321f222c7fe6.png" width="180">|<img src="https://user-images.githubusercontent.com/29531/109709656-835c7300-7b7b-11eb-997b-bba1b73661df.png" width="180">|<img src="https://user-images.githubusercontent.com/29531/109706593-e946fb80-7b77-11eb-9960-b992611d20e2.png" width="180">|<img src="https://user-images.githubusercontent.com/29531/109710276-3d53df00-7b7c-11eb-82cd-113732edc0e7.png" width="180">|<img src="https://user-images.githubusercontent.com/29531/109711258-6e80df00-7b7d-11eb-8913-874b9329a6c5.png" width="180">


# DarkMode

  Added Photos    |     Take a Photo             
:----------------:|:-------------------------:
:<img src="https://user-images.githubusercontent.com/29531/109711299-79d40a80-7b7d-11eb-8e97-2141dcb0ae63.png" width="180">|<img src="https://user-images.githubusercontent.com/29531/109713584-2adba480-7b80-11eb-97d2-0f5d5a027048.PNG" width="180">|

## Architecture 
  - PhotoGrid uses **SwiftUI** framework and it’s default architecture, that is a MV - Model and View utilizing Combine approach, what give us a C - a Controller downplay. Also uses some Views extensions as a ViewModel to split and isolate responsabilities. The PhotoLibraryService is separated as a Repository, to be deacoupled and easily updated if app needs another kind photo’s library in the future.
  - PhotoGrid uses XCTests
  - The tests are splited in Unit and UI tests with some possibilities (is not covering all functionalities).

## How to run the app
```
Clone the app using this repo
Open XCode -> Open project (no workspaces here)
Product -> Run or Command + R to run the project in a simulator or device.
```

## How to run the tests
```Product -> Test or Command + U to run the test suite.```
