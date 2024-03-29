import 'package:flutter/material.dart';
import 'package:soical_user_authentication/src/provider/soical_user_provider.dart';

class LogoutButton extends StatefulWidget {
  final void Function()? onPressed;
  final String? text;
  final Color? textColor;
  final Color? backgroundColor;
  const LogoutButton(
      {this.backgroundColor,
      this.textColor,
      this.onPressed,
      this.text,
      Key? key})
      : super(key: key);

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.2),
      child: ElevatedButton(
        onPressed: widget.onPressed ??
            () async {
              await SoicalUserProvider.of(context).logout();
            },
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(widget.backgroundColor ?? Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios_new,
              color: widget.textColor ?? Colors.black,
            ),
            const Spacer(),
            Text(
              widget.text ?? "Logout",
              textAlign: TextAlign.center,
              style: TextStyle(color: widget.textColor ?? Colors.black),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
