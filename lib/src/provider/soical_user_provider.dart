import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:soical_user_authentication/src/models/soical_user.dart';
import 'package:soical_user_authentication/src/models/user_provider_enum.dart';
import 'package:soical_user_authentication/src/repository/soical_user_repository.dart';

class SoicalUserProvider extends ChangeNotifier {
  SoicalUserRepository soicalUserRepository;
  SoicalUser? currentSoicalUser;
  bool isLoading = false;
  SoicalUserProvider({required this.soicalUserRepository});

  Future<bool> signInWithFacebook() async {
    isLoading = true;
    notifyListeners();
    SoicalUser? user = await soicalUserRepository.signinWithFacebook();
    if (user != null) {
      currentSoicalUser = user;
      isLoading = false;
      notifyListeners();
      return true;
    }
    isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> signInWithGoogle() async {
    isLoading = true;
    notifyListeners();
    SoicalUser? user = await soicalUserRepository.signinWithGoogle();
    if (user != null) {
      currentSoicalUser = user;
      isLoading = false;
      notifyListeners();
      return true;
    }
    isLoading = false;
    notifyListeners();
    return false;
  }

  logout() async {
    isLoading = true;
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
