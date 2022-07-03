# flutter_mvvm_app


## in fact this app main view is bout using clean architecture mvvm not presentation purpose

### things I loved in this app detemining timer for presentation layer to fetch the data from api with the determined time the data cached so no need to fetch every time onley once needed withthin the detemined time the second thing is the state rendering idea and showing pops up above the curent content 

- Clean Architecture Design Pattern MVVM - Model - View - View Model Pattern ViewModel
- Inputs and Outputs Base ViewModel and Base UseCase Application Layer
- Dependency Injection,Routes Manager and Application class Application Layer 
- Extensions and Shared Functions Data Layer 
- Data Sources (Remote Data Source/ Local Data Source) Data Layer 
- API Service Client (Same as Retorfit in Android) Data Layer 
- Calling APIs (Remote Data Source) Data Layer 
- Adding Logger Interceptor Data Layer 
- Caching APIs responses (Local Data Source) Data Layer 
- Json Serialization and Annotations Data Layer 
- Repository Implementation Data Layer 
- Mapper (Converting responses into Models) Data Layer 
- Mapper (Using toDomain Concept) Data Layer 
- Applying Null Safety Data Layer 
- Creating Mock APIs (Stub APIs) Domain Layer 
- Models Domain Layer 
- Repository Interfaces Domain Layer - UseCases Domain Layer 
- Either Concepts (Left - Failure) / (Right - Success) Domain Layer 
- Data Classes Presentation Layer 
- UI (Splash - Onboarding - Login - Register - Forgot Password - Main - Details - Settings - Notification - Search)) 
- Presentation Layer - State Renderer (Full Screen States - Popup States) Presentation Layer 
- State Management (Stream Controller - RX Dart - Stream Builder) Presentation Layer 
- Localizations (English - Arabic), (RTL - LTR) Presentation Layer 
- Assets Manager (Android and Ios Icons and Images sizes) - Presentation Layer 
- (Fonts - Styles - Themes - Strings - Values - Colors) Presentation Layer Managers
- Using Json Animations Presentation Layer - Using SVG images Using alot of Flutter Packages -3rd party- Getting Device Info (Android - Ios) Using Abstract classes

### how to use tha app?
## in fact I have used mockapi for need't purpose for backend developer as i can't for now
## so if you need to *register* use the following data
```
{
  "user_name":"ahmedabdelalem",
  "country_mobile_code":"+20",
  "mobile_number":"01011459031",
  "email":"test@gmail.com",
  "password":"0123456789",
  "profile_picture":""
}
```
## for *login* use the following data
```
{
  "email":"test@gmail.com",
  "password":"123456"
}
```

https://user-images.githubusercontent.com/47370980/177055036-f9350d2c-7ba6-4aeb-832e-f3ff9cd9825b.mp4

