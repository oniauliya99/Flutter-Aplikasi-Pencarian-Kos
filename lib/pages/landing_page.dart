import 'package:flutter/material.dart';
import 'package:golekos/pages/login_page.dart';
import 'package:golekos/theme.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var getStartedBtn = Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          'Get started',
          style: orderRegular.copyWith(
            fontSize: 20,
            color: Color(0xffffffff),
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Color(0xff29D5F8),
          padding: EdgeInsets.symmetric(vertical: 16),
          shadowColor: Colors.black.withOpacity(0.25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
    var loginBtn = Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          var route = MaterialPageRoute(builder: (_) => LoginPage());

          Navigator.of(context).push(route);
        },
        child: Text(
          'Login',
          style: orderRegular.copyWith(
            fontSize: 20,
            color: Color(0xff29D5F8),
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Color(0xffffffff),
          padding: EdgeInsets.symmetric(vertical: 16),
          shadowColor: Colors.black.withOpacity(0.25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );

    // MAIN

    return Scaffold(
      backgroundColor: Color(0xffFAFBFD),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),

              // Golekos logo
              Image.asset(
                'assets/images/golekos_logo.png',
                width: 327,
                height: 215,
              ),

              SizedBox(
                height: 29,
              ),

              // Title
              Text('GOLEKOS',
                  style: orderRegular.copyWith(
                    fontSize: 45,
                    color: Color(0xff29D5F8),
                  )),

              // Message
              Container(
                margin: EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  'The best solution for booking a boarding house',
                  textAlign: TextAlign.center,
                  style: orderRegular.copyWith(
                    fontSize: 20,
                    color: Color(0xff2C2929),
                  ),
                ),
              ),

              SizedBox(
                height: 73,
              ),

              // Get started button
              getStartedBtn,

              SizedBox(
                height: 16,
              ),

              // Login button
              loginBtn,

              SizedBox(
                height: 30,
              ),

              // Login button
              Padding(
                padding: const EdgeInsets.only(left: 90),
                child: Row(
                  children: [
                    Text(
                      'New around here?',
                      style: orderRegular.copyWith(
                          fontSize: 15, color: Color(0xff000000)),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    TextButton(
                      onPressed: () {
                        var route =
                            MaterialPageRoute(builder: (_) => LoginPage());

                        Navigator.of(context).push(route);
                      },
                      child: Text(
                        'Sign in',
                        style: orderRegular.copyWith(
                            fontSize: 15, color: Color(0xff29D5F8)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
