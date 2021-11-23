# HSFM Log
Bacically and instite management app. To maintain class shedule, take attendence, posting importent notice etc

### Some of important sections are
* Setting announcement
* Posting blogs to show their telents
* Avaiable free books
* Recorded videos of classes
* Class wise result

### Technologies behind the app
#### Backend
* firebase
* google signin

### State management
To manage state of this app I used [Riverpod](https://pub.dev/packages/riverpod)

#### To install the project in your IDE
* Copy the project clone link URL
* Pest on the clone section on your IDE
* Write this command to install the packages properly `flutter pub get`
* Now to run the project in your IDE, run the command `flutter run`

## Project structure
```
├───globals
│   ├───configs.dart
│   └───controllers
├───models
├───services
├───utils
│   ├───auth_repos
│   └───firestore_repos
└───views
    ├───route_management
    ├───screens
    │   ├───add_notice_screem    
    │   ├───admin_page
    │   ├───annoucement_details  
    │   ├───editable_notices_list
    │   ├───emty_list_screen     
    │   ├───home_page
    │   ├───nav_bar
    │   ├───notice_details       
    │   ├───no_internet_screen   
    │   ├───profile
    │   ├───see_all_announcements
    │   ├───something_went_wrong 
    │   ├───splash_screen        
    │   └───tabs
    │       ├───account_tab
    │       │   ├───compoents
    │       │   └───login_screen
    │       ├───feeds
    │       ├───home_tab
    │       │   └───components
    │       └───notification_tab
    ├───shared_widgets
    └───styles
    
