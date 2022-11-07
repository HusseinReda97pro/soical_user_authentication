import 'dart:convert';

import 'package:soical_user_authentication/src/models/user_provider_enum.dart';

class SoicalUser {
  String id;
  String name;
  String email;
  String? imageURL;
  UserProvider provider;
  SoicalUser({
    required this.id,
    required this.provider,
    required this.name,
    required this.email,
    this.imageURL,
  });

  Map<String, dynamic> get toMap {
    return {
      "id": id,
      "name": name,
      "email": email,
      "image_url": imageURL,
      "provider": provider
    };
  }

  String get toJsos => json.encode(toMap);

  factory SoicalUser.fromJson(data) => fromMap(json.decode(data));
  @override
  String toString() {
    return 'id:$id, username: $name, email: $email, ImageUrl: $imageURL, provider: ${provider.toString()}';
  }

  factory SoicalUser.fromFacebook(data) => SoicalUser(
        provider: UserProvider.facebook,
        name: data['name'],
        email: data['email'],
        imageURL: data['picture']?['data']?['url'],
        id: data['id'],
      );

  factory SoicalUser.fromGoogle(googleSignInAccount) => SoicalUser(
        provider: UserProvider.google,
        id: googleSignInAccount.id,
        name: googleSignInAccount.displayName ?? '',
        email: googleSignInAccount.id,
        imageURL: googleSignInAccount.photoUrl,
      );

  static SoicalUser fromMap(Map<String, dynamic> data) {
    return SoicalUser(
        id: data['id'],
        name: data['name'],
        email: data['email'],
        imageURL: data['image_url'],
        provider: data['provider']);
  }
}
