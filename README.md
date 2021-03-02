# PhotoGrid

- Architecture 
  - PhotoGrid uses **SwiftUI** framework and it’s default architecture, that is a MV - Model and View utilizing Combine approach, what give us a C - a Controller downplay. Also uses some Views extensions as a ViewModel to split and isolate responsabilities. The PhotoLibraryService is separated as a Repository, to be deacoupled and easily updated if app needs another kind photo’s library in the future.
  - PhotoGrid uses XCTests
  - The tests are splited in Unit and UI tests with some possibilities (is not covering all functionalities).
- How to run the app
  - Clone the app using this repo
  - Open XCode -> Open project (no workspaces here)
  - Product -> Run or Command + R to run the project in a simulator or device.
- How to run the tests
  - Product -> Test or Command + U to run the test suite.
- Features
  - Take a new photo using camera device 
    - or pick one from the the library photo if you need to use on a simulator
  - See you photos on PhotoGrid list
  - Tap photos in the list to see it larger
  - Users can mark a photo as a favorite to see it on PhotoGrid’s list
  - Delete photo with a longpress. 
  - As PhotoGrid only displays it’s own photos, users can remove photos from the app and after that they choose to keep or remove from library too.
