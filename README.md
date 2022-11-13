<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

this package for login over social media, currently it support login using Facebook, or google

## Features

you can use this package for
login user using Facebook
login user Using Google
logout user from facebook
logout user from google

store current user in provider (State management if you use it)

### In this Package, there are three ways to use it:


1. You can use Ui Widgets.
2. you can use state mangment Solution used in this pacged wich is Provider and use functions and current user, loading state,and error form it.
3. You can use repostory that have the logic for social authentication

## Getting started

prerequisites to start using the package.


For Facebook:
first step you need to complete create Facebook app and link it to your project for Android, and IOS,
as this Package depend on [flutter_facebook_auth](https://pub.dev/packages/flutter_facebook_auth)
and there is [documentation](https://facebook.meedu.app/docs/5.x.x/intro) for the process.

For Google: 
first step you need to complete create Google app on [Cloud Console](https://console.cloud.google.com/apis/dashboard) and link it to your project for Android, and IOS, as this Package depend on [google_sign_in](https://pub.dev/packages/google_sign_in).


## Usage

add package:

````
soical_user_authentication:
    git:  
      url: https://github.com/HusseinReda97pro/soical_user_authentication
````

import package:

````
import 'package:soical_user_authentication/soical_user_authentication.dart';
````


For UI 

standerd UI 

![image](https://user-images.githubusercontent.com/47584580/200312074-fedc6417-61a4-41a6-a764-eeb8e8e8da77.png)

````
  const SigninFacebookButton() // has optional parameter text: for button text, onPressed function 
  const SigninGoogleButton() //  has optional parameter text: for button text, onPressedr function
  const LogoutButton() // has optional parameter text: for button text,colors backgroundColor, textColor, onPressed function 
  hint: you must pass your onPressed function in case you will not use provider.
 ````
 
how it works:
   when using Signin button you need to use SoicalUserProvider also.
   
 
### you need to wrap MaterialApp with SoicalUserProvider 
 
 ```
 MultiProvider(
      providers: [
        ChangeNotifierProvider<SoicalUserProvider>(
          create: (_) => SoicalUserProvider(
            soicalUserRepository: SoicalUserRepository(),
          ),
        ),
      ],
      child: MaterialApp(
      .......
      ),);
 ```
 
when pressed on any button  the isLoading value on provider is turned to true, 
and currentUser will be the User data that got if user accepts and null otherwise then isLoading be false again.
and error will has value:
- for Facebook: User has cancelled login with facebook
- for Google: User has cancelled login with Google


````
SoicalUserProvider.of(context).currentSoicalUser 
SoicalUserProvider.of(context).isLoading

SoicalUserProvider.of(context).signInWithFacebook()
SoicalUserProvider.of(context).signInWithGoogle()
SoicalUserProvider.of(context).logout()

````
#### logout()
logout form facebook or google and turn currentSoicalUser to null.

### Soical User Data
And this is the data of user 
 ````
  String id; // Soical id 
  String name;
  String email;
  String? imageURL;
  UserProvider provider;
 ````
 
#### User Provider values
 
 ````
  UserProvider.google 
  UserProvider.facebook 
  UserProvider.emailPassword
 ````
 
  UserProvider enum has it's function to cast from and to string
  ```
  toText()
      UserProvider.google  >> "google"
      UserProvider.facebook  >> "facebook"
      UserProvider.emailPassword  >> "emailPassword"
  toUserProvider()
      "facebook".toUserProvider() >> UserProvider.facebook
      "google".toUserProvider() >> UserProvider.google
      "emailPassword".toUserProvider() >> UserProvider.emailPassword
  ```

 -> Hint defult value is emailPassword if is no matched case.
 
## In case you prefer to use another UI or State Management Solution

you can use logic directly  from repository from SoicalUserRepository()

````
SoicalUserRepository soicalUserRepository = SoicalUserRepository();
UserResponse userResponse = await soicalUserRepository.signinWithFacebook();
UserResponse userResponse = await soicalUserRepository.signinWithGoogle();
// hint in case failed authentication or user declaint UserResponse.user will be null 
// UserResponse.error will has value.
soicalUserRepository.logoutFromFacebook()
soicalUserRepository.logoutFromGoogle()
````

