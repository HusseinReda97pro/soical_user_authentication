import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:soical_user_authentication/src/provider/soical_user_provider.dart';

class SigninGoogleButton extends StatefulWidget {
  final String? text;
  final Function? onPressed;
  const SigninGoogleButton({this.text, this.onPressed, Key? key})
      : super(key: key);

  @override
  State<SigninGoogleButton> createState() => _SigninGoogleButtonState();
}

class _SigninGoogleButtonState extends State<SigninGoogleButton> {
  @override
  Widget build(BuildContext context) {
    return SignInButton(
      Buttons.Google,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      text: widget.text,
      onPressed: widget.onPressed ??
          () async {
            SoicalUserProvider.of(context).signInWithGoogle();
          },
    );
  }
}
