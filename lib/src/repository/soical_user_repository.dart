import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soical_user_authentication/src/models/soical_user.dart';
import 'package:soical_user_authentication/src/network_services/networking_services.dart';
import 'package:soical_user_authentication/src/network_services/status_codes.dart';

class SoicalUserRepository {
  String _graphAPIBaseUrl = 'https://graph.facebook.com/me/permissions';

  Future<SoicalUser?> signinWithFacebook() async {
    // AccessToken? accessToken;
    SoicalUser? user;
    final loginRuslt = await FacebookAuth.i.login();
    if (loginRuslt.status == LoginStatus.success) {
      // accessToken = loginRuslt.accessToken;
      var userData = await FacebookAuth.i.getUserData();
      user = SoicalUser.fromFacebook(userData);
    }
    return user;
  }

  Future<SoicalUser?> signinWithGoogle() async {
    SoicalUser? user;
    var googleSignIn = GoogleSignIn();
    try {
      var isSignedIn = await googleSignIn.isSignedIn();
      if (isSignedIn && googleSignIn.currentUser != null) {
        var userData = googleSignIn.currentUser;
        if (userData != null) {
          user = SoicalUser.fromGoogle(userData);
        }
      } else {
        var userData = await googleSignIn.signIn();
        user = SoicalUser.fromGoogle(userData);
      }
    } catch (_) {}
    return user;
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
