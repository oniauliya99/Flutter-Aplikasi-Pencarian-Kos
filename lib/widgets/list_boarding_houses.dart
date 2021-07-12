import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:golekos/pages/detail_page.dart';
import '../theme.dart';
import 'package:intl/intl.dart';

class BoardingHouses extends StatelessWidget {
  const BoardingHouses({this.product, this.detector, this.user});

  final User user;
  final product;
  final int detector; // value-nya buat ngatur border radius

  @override
  Widget build(BuildContext context) {
    // Format uang
    final currencyFormat = NumberFormat("#,##0", "en_US");

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      child: ListTile(
        // TODO: Add activity here

        onTap: () {
          MaterialPageRoute route = MaterialPageRoute(
              builder: (_) => DetailPage(
                    product,
                    user: user,
                  ));
          Navigator.push(context, route);
        },
        contentPadding: EdgeInsets.all(16),
        title: Row(
          children: [
            Container(
              width: 150, // Jarak biar ngga terlalu over
              child: Text(
                product['kost_name'] ?? "Product name",
                style: orderMedium.copyWith(
                    fontSize: 16, color: Color(0xff040507)),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Spacer(),
            Text(
              'Rp ${currencyFormat.format(product['kost_price_per_month']) ?? 0}',
              style: orderBold.copyWith(fontSize: 14, color: Color(0xff040507)),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            Text(
              product['kost_type'] ?? "Product type",
              style:
                  orderLight.copyWith(fontSize: 12, color: Color(0xffA5A5A5)),
            ),
            Spacer(),
            Text(
              '/month',
              style:
                  orderLight.copyWith(fontSize: 12, color: Color(0xffA5A5A5)),
            ),
          ],
        ),
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              product['kost_images'] ?? 'https://via.placeholder.com/150',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            )),

        // ListTile style

        shape: RoundedRectangleBorder(
          borderRadius: (detector == 0)
              ? BorderRadius.zero
              : ((detector == 1)
                  ? BorderRadius.vertical(top: Radius.circular(16))
                  : BorderRadius.vertical(bottom: Radius.circular(16))),
        ),
      ),

      // Card style

      shape: RoundedRectangleBorder(
        /**
         * 
         * Jika detector terdeteksi 0, maka hilangkan border
         * Jika detector terdeteksi 1, maka aktifkan border top
         * Selain itu, aktifkan border bottom
         * 
         */

        borderRadius: (detector == 0)
            ? BorderRadius.zero
            : ((detector == 1)
                ? BorderRadius.vertical(top: Radius.circular(16))
                : BorderRadius.vertical(bottom: Radius.circular(16))),
      ),
    );
  }
}
