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

### In this Package, there are two ways to use it:


1. You can use Ui Widgets:




2. you can use state mangment Solution used in this pacged wich is Provider and use functions and current user and loading state form it.
3. You Repostory that have logic for Authentication

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
  const SigninFacebookButton() // has optional parameter text: for button text
  const SigninGoogleButton() //  has optional parameter text: for button text
  const LogoutButton() // has optional parameter text: for button text,colors backgroundColor, textColor, onPressed Function if you need use different logic.
 ````
 
how it works:
    when using  Signin button  you need to use SoicalUserProvider also.
    when pressed on it the isLoading value on provider is turn to true, and currentUser will be the User data that got if user accept and null otherwise then isLoading     be false again.
 
 you need to wrap MaterialApp with SoicalUserProvider
 
 
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
 
 
````
SoicalUserProvider.of(context).currentSoicalUser
SoicalUserProvider.of(context).isLoading

SoicalUserProvider.of(context).signInWithFacebook()
SoicalUserProvider.of(context).signInWithGoogle()
SoicalUserProvider.of(context).logout()

````
    
    
And this is the data of user 
 ````
  String id;
  String name;
  String email;
  String? imageURL;
  UserProvider provider;
 ````
 
 UserProvider values
 
 ````
  UserProvider.google 
  UserProvider.facebook 
 ````
  
  
  
In case you prefer to use another UI or State Management Solution

you can use logic direct from repository from SoicalUserRepository()

````
Future<SoicalUser?> signinWithFacebook()
Future<SoicalUser?> signinWithGoogle() 
// hint in case failed authentication or user declaint function will return null
Future<void> logoutFromFacebook()
Future<void> logoutFromGoogle()
````

