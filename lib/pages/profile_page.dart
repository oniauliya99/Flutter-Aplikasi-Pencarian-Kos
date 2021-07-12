import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:golekos/services/db_services.dart';
import 'package:golekos/theme.dart';
import 'package:golekos/widgets/alert_logout.dart';
import '../widgets/card_tile.dart';

class Profile extends StatefulWidget {
  final User user;
  Profile([this.user]);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    // Profile Section

    var profileSection = Container(
      child: Stack(
        children: [
          Center(
            child: Container(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/man.png'),
                backgroundColor: Colors.transparent,
                radius: 30,
              ),
              transform: Matrix4.translationValues(0, -50, 0),
              width: 100,
              height: 100,
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 62,
              ),
              Text(
                widget.user?.email ?? 'Guest',
                style: orderSemiBold.copyWith(
                    fontSize: 20, color: Color(0xFFFFFFFF)),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                'Mahasiswa',
                style: orderRegular.copyWith(color: Color(0xFFC7C7C9)),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [],
              ),
            ],
          ),
        ],
      ),
    );

    // Transaction Section

    var transactionSection = [
      SizedBox(
        height: 120,
      ),

      // Profile section
      profileSection,

      SizedBox(
        height: 20,
      ),

      // Transaction section

      SizedBox(
        height: 20,
      ),
      Expanded(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Transaction',
                style: orderSemiBold.copyWith(
                    fontSize: 16, color: Color(0xff000000)),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: DatabaseServices.orderStream(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snap) {
                      if (snap.hasError) {
                        return Center(
                          child: Text(
                              'Failed to load transaction data, try again'),
                        );
                      } else if (snap.data != null) {
                        var docLength = snap.data.docs.length;
                        if (docLength == 0) {
                          return Center(
                            child: Text('You don\'t have any transactions'),
                          );
                        }
                      }

                      if (snap.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Loading..'),
                              SizedBox(
                                height: 16,
                              ),
                              CircularProgressIndicator(),
                            ],
                          ),
                        );
                      }

                      if (snap.hasData) {
                        return ListView(
                          shrinkWrap: true,
                          children: snap.data.docs.map((DocumentSnapshot doc) {
                            Map<String, dynamic> data =
                                doc.data() as Map<String, dynamic>;

                            return CardTile(
                              id: doc.id,
                              object: data,
                              onDelete: () {
                                orders.doc(doc.id).delete();
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                            );
                          }).toList(),
                        );
                      } else {
                        return Center(
                          child: Text('No data here'),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
        ),
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/bg_profile.png'),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showAlertDialog(context);
                  },
                  tooltip: 'Logout this session',
                ),
              ],
            ),
          ),
          // Navigation bar - First layer
          // Profile and Transaction - Second layer
          Column(
            children: transactionSection,
          ),
        ],
      ),
    );
    // set up the buttons

    // set up the AlertDialog
  }
}

Image socialButton(String imgUrl) {
  return Image.asset(
    imgUrl,
    width: 40,
    height: 40,
  );
}
