import 'package:flutter/material.dart';
import 'package:golekos/theme.dart';
import 'package:email_validator/email_validator.dart';
import 'package:golekos/services/auth_services.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool passwordVisible = false;
  String emaill = "";
  final formKey = GlobalKey<FormState>();
  final form2Key = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    email.addListener(onListen);
  }

  @override
  void dispose() {
    email.removeListener(onListen);
    super.dispose();
  }

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      backgroundColor: Color(0xFFFFAFBFD),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Container(
                height: 110,
                margin: EdgeInsets.only(bottom: 30),
                alignment: Alignment.center,
                child: Image.asset("assets/images/golekos_logo.png")),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              alignment: Alignment.center,
              child: Text(
                'Sign Up',
                style: orderRegular.copyWith(fontSize: 36),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.only(left: 40, right: 40, bottom: 17),
              height: 60,
              width: 90,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: new TextFormField(
                        controller: email,
                        style: orderRegular.copyWith(fontSize: 20),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 2, 5),
                          hintText: 'Email address',
                          suffixIcon: email.text.isEmpty
                              ? Container(width: 0)
                              : IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () => email.clear()),
                          hintStyle: orderRegular.copyWith(
                              fontSize: 20, color: Color(0x6C383737)),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {},
                        validator: (value) => EmailValidator.validate(value)
                            ? null
                            : "Please enter a valid email",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.only(left: 40, right: 40, bottom: 17),
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
                    obscureText: passwordVisible,
                    style: orderRegular.copyWith(fontSize: 20),
                    decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          child: Icon((passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off)),
                        ),
                        hintStyle: orderRegular.copyWith(
                            fontSize: 20, color: Color(0x6C383737)),
                        border: InputBorder.none),
                    onChanged: (value) {},
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 30),
              child: Text(
                'One more step to register an account',
                style: orderRegular.copyWith(fontSize: 15, color: Colors.grey),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 40, right: 40, top: 10),
              height: 65,
              child: InkWell(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Color(0XFF29D5F8),
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            'Sign up now',
                            style: orderRegular.copyWith(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () async {
                  final form = formKey.currentState;
                  final form2 = form2Key.currentState;
                  if (form.validate() && form2.validate()) {
                    AuthService.signUpWithEmailAndPassword(
                            email.text, password.text)
                        .then(
                      (result) {
                        if (result != null) {
                          Navigator.pop(context);
                        }
                      },
                    );
                  }
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 110),
              child: Text(
                'You are completely safe',
                style: orderBold.copyWith(fontSize: 15, color: Colors.black),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Read Our Terms & Conditions.',
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
