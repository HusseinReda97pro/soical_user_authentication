import 'package:soical_user_authentication/soical_user_authentication.dart';

class UserResponse {
  SoicalUser? soicalUser;
  String? error;
  UserResponse({this.soicalUser, this.error});
}
