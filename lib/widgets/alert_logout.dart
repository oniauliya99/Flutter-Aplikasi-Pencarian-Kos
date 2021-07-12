import 'package:flutter/material.dart';
import 'package:golekos/pages/login_page.dart';
import 'package:golekos/services/auth_services.dart';

showAlertDialog(BuildContext context) {
  Widget cancelButton = FlatButton(
    child: Text(
      "Cancel",
      style: TextStyle(color: Colors.blueAccent),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text(
      "Continue",
      style: TextStyle(color: Colors.red),
    ),
    onPressed: () {
      AuthService.signOut();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return LoginPage();
      }), (route) => false);
    },
  );
  AlertDialog alert = AlertDialog(
    title: Icon(
      Icons.warning,
      color: Colors.red,
    ),
    content: Text("Are you sure you want to exit ?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
