import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soical_user_authentication/src/models/soical_user.dart';
import 'package:soical_user_authentication/src/models/user_response.dart';
import 'package:soical_user_authentication/src/network_services/networking_services.dart';
import 'package:soical_user_authentication/src/network_services/status_codes.dart';

class SoicalUserRepository {
  final String _graphAPIBaseUrl = 'https://graph.facebook.com/me/permissions';

  Future<UserResponse> signinWithFacebook() async {
    // AccessToken? accessToken;
    UserResponse userResponse = UserResponse();
    final loginRuslt = await FacebookAuth.i.login();
    if (loginRuslt.status == LoginStatus.success) {
      var userData = await FacebookAuth.i.getUserData();
      userResponse.soicalUser = SoicalUser.fromFacebook(userData);
    }
    if (loginRuslt.status == LoginStatus.cancelled) {
      userResponse.error = "User has cancelled login with facebook";
    }
    return userResponse;
  }

  Future<UserResponse> signinWithGoogle() async {
    UserResponse userResponse = UserResponse();
    var googleSignIn = GoogleSignIn();
    try {
      var isSignedIn = await googleSignIn.isSignedIn();
      if (isSignedIn && googleSignIn.currentUser != null) {
        var userData = googleSignIn.currentUser;
        if (userData != null) {
          userResponse.soicalUser = SoicalUser.fromGoogle(userData);
        }
      } else {
        try {
          var userData = await googleSignIn.signIn();

          userResponse.soicalUser = SoicalUser.fromGoogle(userData);
        } catch (e) {
          userResponse.error = "User has cancelled login with Google";
        }
      }
    } catch (_) {}
    return userResponse;
  }

  Future<bool> _deleteFacebookToken() async {
    var token = await FacebookAuth.i.accessToken;
    try {
      var response = await NetworkServices.instance.delete(
          url: _graphAPIBaseUrl,
          queryParameters: {"access_token": token?.token ?? ''});
      if (response.data['success'] &&
          response.statusCode == StatusCode.success) {
        return true;
      }
    } catch (_) {}
    return false;
  }

  Future<void> logoutFromFacebook() async {
    bool deleteToken = await _deleteFacebookToken();
    if (deleteToken) {
      await FacebookAuth.i.logOut();
    }
  }

  Future<void> logoutFromGoogle() async {
    var googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }
}
