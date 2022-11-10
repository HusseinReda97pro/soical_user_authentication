import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:soical_user_authentication/src/provider/soical_user_provider.dart';

class SigninFacebookButton extends StatefulWidget {
  final String? text;
  final Function? onPressed;
  final SoicalUserProvider? provider;
  const SigninFacebookButton(
      {this.text, this.provider, this.onPressed, Key? key})
      : super(key: key);

  @override
  State<SigninFacebookButton> createState() => _SigninFacebookButtonState();
}

class _SigninFacebookButtonState extends State<SigninFacebookButton> {
  @override
  Widget build(BuildContext context) {
    return SignInButton(
      Buttons.FacebookNew,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      text: widget.text,
      onPressed: widget.onPressed != null
          ? widget.onPressed!()
          : widget.provider != null
              ? () {
                  widget.provider!.signInWithFacebook();
                }
              : () async {
                  SoicalUserProvider.of(context).signInWithFacebook();
                },
    );
  }
}
