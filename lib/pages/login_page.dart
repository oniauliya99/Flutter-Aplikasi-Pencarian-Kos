import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:golekos/pages/sign_up_page.dart';
import 'package:golekos/services/auth_services.dart';
import 'package:golekos/theme.dart';
import 'package:golekos/wrapper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool paswordVisible = true;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final form2Key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F6FD),
      body: Container(
        margin: EdgeInsets.only(top: 30),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 30),
              alignment: Alignment.center,
              child: Text(
                'Sign In',
                style: orderRegular.copyWith(fontSize: 36),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 40, right: 40, bottom: 10),
              height: 65,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.white,
                child: ElevatedButton(
                  onPressed: () async {
                    var user = await AuthService.signInAnonymous();
                    if (user != null) {
                      var route = MaterialPageRoute(builder: (_) => Wrapper());
                      Navigator.of(context).push(route);
                    }
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 22,
                      ),
                      Image.asset(
                        'assets/images/sign_in/logo.png',
                        width: 24,
                        height: 24,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 46,
                      ),
                      Text(
                        'Sign in as Guest',
                        style: orderRegular.copyWith(
                          fontSize: 20,
                          color: Color(0xff2C2929),
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffffffff),
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
            ),

            // SIGN IN WITH GOOGLE

            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              height: 65,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.white,
                child: ElevatedButton(
                  onPressed: () {
                    AuthService.signInWithGoogle().then((result) {
                      if (result != null) {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return Wrapper();
                        }));
                      }
                    });
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 22,
                      ),
                      Image.asset(
                        'assets/images/sign_in/google.png',
                        width: 24,
                        height: 24,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 32,
                      ),
                      Text(
                        'Sign in with Google',
                        style: orderRegular.copyWith(
                          fontSize: 20,
                          color: Color(0xff4285F4),
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffffffff),
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 30),
              child: Text(
                'or get a link emailed to you',
                style: orderRegular.copyWith(fontSize: 15, color: Colors.grey),
              ),
            ),
            new ListTile(
              title: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                height: 60,
                child: Form(
                  key: formKey,
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    alignment: Alignment.center,
                    child: new TextFormField(
                      controller: email,
                      keyboardType: TextInputType.text,
                      style: orderRegular.copyWith(fontSize: 20),
                      decoration: InputDecoration(
                          hintText: 'E-mail',
                          suffixIcon: email.text.isEmpty
                              ? Container(width: 0)
                              : IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () => email.clear()),
                          hintStyle: orderRegular.copyWith(
                            fontSize: 20,
                            color: Color(0x6C383737),
                          ),
                          border: InputBorder.none),
                      onChanged: (value) {},
                      validator: (value) => EmailValidator.validate(value)
                          ? null
                          : "Please enter a valid email",
                    ),
                  ),
                ),
              ),
            ),
            new ListTile(
              title: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                height: 60,
                child: Form(
                  key: form2Key,
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    alignment: Alignment.center,
                    child: new TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Empty Field, Please enter some text';
                        } else if (value.length < 8) {
                          return 'Must be more than 8 charater';
                        }
                      },
                      controller: password,
                      obscureText: paswordVisible,
                      keyboardType: TextInputType.text,
                      style: orderRegular.copyWith(fontSize: 20),
                      decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                paswordVisible = !paswordVisible;
                              });
                            },
                            child: Icon(
                              (paswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                          hintStyle: orderRegular.copyWith(
                            fontSize: 20,
                            color: Color(0x6C383737),
                          ),
                          border: InputBorder.none),
                      onChanged: (value) {},
                    ),
                  ),
                ),
              ),
            ),

            // Login with email and password

            Container(
              margin: EdgeInsets.only(left: 40, right: 40, top: 10),
              height: 65,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Color(0XFF29D5F8),
                child: ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Container(
                          child: Text(
                            'LOGIN TO ACCOUNT',
                            style: orderRegular.copyWith(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                        onTap: () async {
                          final form = formKey.currentState;
                          final form2 = form2Key.currentState;
                          if (form.validate() && form2.validate()) {
                            AuthService.signInWithEmailAndPassword(
                                    email.text, password.text)
                                .then((result) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Wrapper(),
                                ),
                              );
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    'or register now ',
                    style: orderSemiBold.copyWith(
                        fontSize: 15, color: Colors.grey),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 30),
                  child: GestureDetector(
                    child: Text(
                      'here ',
                      style: orderRegular.copyWith(
                          fontSize: 15, color: Colors.grey),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 70),
              child: Text(
                'You are completely safe',
                style: orderBold.copyWith(fontSize: 15, color: Colors.black),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Read Our Terms & Conditions',
                style: orderRegular.copyWith(
                    fontSize: 15, color: Color(0XFF7041EE)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
