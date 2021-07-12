import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:golekos/pages/buttom_bar.dart';
import 'package:golekos/pages/landing_page.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Check if the previous user data is still available, if there is any, then navigate to the dashboard or landing page if it's not there.

    User user = Provider.of<User>(context);
    return (user == null)
        ? LandingPage()
        : ButtomBar(
            user: user,
          );
  }
}
