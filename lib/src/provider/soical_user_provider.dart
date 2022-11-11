import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:soical_user_authentication/src/models/soical_user.dart';
import 'package:soical_user_authentication/src/models/user_provider_enum.dart';
import 'package:soical_user_authentication/src/models/user_response.dart';
import 'package:soical_user_authentication/src/repository/soical_user_repository.dart';

class SoicalUserProvider extends ChangeNotifier {
  SoicalUserRepository soicalUserRepository;
  SoicalUser? currentSoicalUser;
  String? error;
  bool isLoading = false;
  SoicalUserProvider({required this.soicalUserRepository});

  Future<bool> signInWithFacebook() async {
    isLoading = true;
    error = null;
    notifyListeners();
    UserResponse userResponse = await soicalUserRepository.signinWithFacebook();
    if (userResponse.soicalUser != null) {
      currentSoicalUser = userResponse.soicalUser;
      isLoading = false;
      notifyListeners();
      return true;
    } else {
      if (userResponse.error != null) {
        error = userResponse.error;
        isLoading = false;
        notifyListeners();
        return false;
      }
    }
    isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> signInWithGoogle() async {
    isLoading = true;
    error = null;
    notifyListeners();
    UserResponse userResponse = await soicalUserRepository.signinWithGoogle();
    if (userResponse.soicalUser != null) {
      currentSoicalUser = userResponse.soicalUser;
      isLoading = false;
      notifyListeners();
      return true;
    } else {
      if (userResponse.error != null) {
        error = userResponse.error;
        isLoading = false;
        notifyListeners();
        return false;
      }
    }
    isLoading = false;
    notifyListeners();
    return false;
  }

  logout() async {
    isLoading = true;
    error = null;
    notifyListeners();
    if (currentSoicalUser != null &&
        currentSoicalUser!.provider == UserProvider.facebook) {
      await soicalUserRepository.logoutFromFacebook();
    }
    if (currentSoicalUser != null &&
        currentSoicalUser!.provider == UserProvider.google) {
      await soicalUserRepository.logoutFromGoogle();
    }
    currentSoicalUser = null;
    isLoading = false;
    notifyListeners();
  }

  static SoicalUserProvider of(BuildContext context, {bool listen = false}) {
    if (listen) return context.watch<SoicalUserProvider>();
    return context.read<SoicalUserProvider>();
  }
}
