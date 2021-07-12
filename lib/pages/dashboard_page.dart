import 'package:flutter/material.dart';
import 'package:golekos/theme.dart';
import 'package:golekos/widgets/list_boarding_houses.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:golekos/models/product.dart';

class Dashboard extends StatefulWidget {
  final User user;

  Dashboard([this.user]);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var singleProduct;
  int productRadius = 0;

  TextEditingController search = TextEditingController();

  String searchProduct = '';

  @override
  void initState() {
    super.initState();
  }

  Future<List<Product>> getAllProduct() async {
    var result = await Product.getProduct(name: searchProduct);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    // Welcome to app message

    var headerApp = Container(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello,',
                style:
                    orderBold.copyWith(fontSize: 29, color: Color(0xff040507)),
              ),

              // Username is displayed here

              Container(
                width: 250,
                child: Row(
                  children: [
                    Text(
                      (widget.user?.email != null)
                          ? widget.user.email
                          : 'Guest',
                      style: orderRegular.copyWith(
                          fontSize: 13, color: Color(0xff040507)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Spacer(),

          // User profile shown here

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/man.png',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );

    // MAIN

    return Scaffold(
      backgroundColor: Color(0xffF2F6FD),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),

              // Welcome message and profile

              headerApp,

              SizedBox(
                height: 30,
              ),

              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search product

                    TextField(
                      controller: search,
                      decoration: InputDecoration(
                        // textfield hint

                        hintText: "Find a boarding room here",
                        hintStyle: orderLight.copyWith(
                            fontSize: 16, color: Color(0xffA5A5A5)),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              searchProduct = search.text;
                            });
                          },
                          icon: Icon(Icons.search_rounded),
                          color: Color(0xffA5A5A5),
                          iconSize: 20,
                        ),

                        // textfield style

                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(16),

                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(color: Colors.transparent)),
                      ),

                      // texfield settings

                      maxLength: 25,
                      maxLines: 1,
                      textInputAction: TextInputAction.search,
                      style: orderRegular.copyWith(
                          fontSize: 16, color: Color(0xffA5A5A5)),
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    // Tips

                    Image.asset(
                      'assets/images/tips.png',
                    ),

                    SizedBox(
                      height: 27,
                    ),

                    Text('Most People Go',
                        style: orderSemiBold.copyWith(
                          fontSize: 18,
                          color: Color(0xff040507),
                        )),
                    SizedBox(
                      height: 16,
                    ),

                    // List of product

                    MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: FutureBuilder(
                        builder: (context, snap) {
                          if (snap.hasError) {
                            return Center(
                              child: Text(
                                  'Failed to load transaction data, try again'),
                            );
                          } else if (snap.data != null) {
                            var docLength = snap.data.length;
                            if (docLength == 0) {
                              return Center(
                                child: Column(
                                  children: [
                                    Text('Product not available right now'),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          setState(() {});
                                        },
                                        child: Text('Refresh Pages'))
                                  ],
                                ),
                              );
                            }
                          }

                          if (snap.connectionState == ConnectionState.done) {
                            return ListView.builder(
                              itemCount: snap.data?.length ?? 0,
                              itemBuilder: (context, pos) {
                                singleProduct = null;
                                Product retrieveProduct = snap.data[pos];

                                try {
                                  if (pos == 0) {
                                    // Jika saat ini di posisi pertama, maka aktifkan radius top
                                    productRadius = 1;
                                  } else if (pos == (snap.data.length - 1)) {
                                    // Jika saat ini di posisi terakhir, maka aktifkan radius bottom
                                    productRadius = 2;
                                  } else {
                                    // Jika tidak keduanya, maka nonaktifkan radius [kotak polosan]
                                    productRadius = 0;
                                  }
                                } catch (e) {
                                  print(e.toString());
                                }

                                singleProduct = {
                                  'kost_id': retrieveProduct.id,
                                  'kost_name': retrieveProduct.name,
                                  'kost_type': retrieveProduct.type,
                                  'kost_desc': retrieveProduct.desc,
                                  'kost_master_bed':
                                      retrieveProduct.numberOfBed,
                                  'kost_bathrooms':
                                      retrieveProduct.numberOfBath,
                                  'kost_kitchen':
                                      retrieveProduct.numberOfKitchen,
                                  'kost_wifi_ready': retrieveProduct.wifiReady,
                                  'kost_owner': retrieveProduct.owner,
                                  'kost_owner_phone':
                                      retrieveProduct.ownerPhone,
                                  'kost_images': retrieveProduct.imageUrl,
                                  'kost_price_per_month': retrieveProduct.price,
                                  'kost_location': retrieveProduct.location,
                                  'kost_stock': retrieveProduct.qty
                                };

                                return BoardingHouses(
                                  product: singleProduct,
                                  detector: productRadius,
                                  user: widget.user,
                                );
                              },
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                            );
                          }

                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Loading..',
                                    style: orderRegular.copyWith(
                                      fontSize: 18,
                                      color: Color(0xff040507),
                                    )),
                                SizedBox(
                                  height: 16,
                                ),
                                CircularProgressIndicator(),
                              ],
                            ),
                          );
                        },
                        future: getAllProduct(),
                      ),
                    ),

                    // The distance between the product list and bottom navigation

                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom navigation
    );
  }
}
