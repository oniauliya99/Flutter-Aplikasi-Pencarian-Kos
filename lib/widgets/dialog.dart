import 'package:flutter/material.dart';
import '../theme.dart';

// TODO: DEFAULT INFORMATION MESSAGEE

// Payment information

Future<dynamic> paymentInformation(BuildContext context) {
  return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.payment,
                color: Colors.blue,
                size: 15,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'Payment Information',
                style:
                    orderBold.copyWith(fontSize: 14, color: Colors.blueAccent),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // PLEASE READ BEFORE PAYMENT

                Text(
                  'PLEASE READ !!!\n\n If you make a transaction in the Golekos application, it means that you have complied with the policies made by ORITech Corporation. Anything prohibited will be the responsibility of the user. If you agree to these rules, you may transfer payments to the following account.',
                  style: orderRegular.copyWith(color: Colors.grey),
                  textAlign: TextAlign.justify,
                ),

                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.5),
                ),
                SizedBox(
                  height: 10,
                ),

                Text(
                  'BANK ACCOUNT',
                  style: orderBold.copyWith(color: Colors.blueAccent),
                ),

                SizedBox(
                  height: 10,
                ),

                // BANK INFORMATION

                accountInformation('BCA', '2190249328'),
                accountInformation('MANDISENDIRI', '0948974959'),
                accountInformation('BNI', '0213099034'),

                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.5),
                ),
                SizedBox(
                  height: 10,
                ),

                Text(
                  'CONFIRM PAYMENT',
                  style: orderBold.copyWith(color: Colors.blueAccent),
                ),

                SizedBox(
                  height: 10,
                ),

                Text(
                  'Confirm your payment to the following number',
                  style: orderRegular.copyWith(color: Colors.grey),
                  textAlign: TextAlign.justify,
                ),

                SizedBox(
                  height: 10,
                ),

                accountInformation('Oni chan', '08310309434'),
                accountInformation('Irfan kun', '08920309439'),
                accountInformation('Ridlo sama', '08101434983'),

                SizedBox(
                  height: 10,
                ),
                Text(
                  '*Hint: hold the account number to copy',
                  style: orderRegular.copyWith(color: Colors.black45),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Done')),
          ],
        );
      });
}

// Payment information - Account Information

accountInformation(String name, String number) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: orderBold.copyWith(color: Colors.black54),
        ),
        SelectableText(
          number,
          style: orderBold.copyWith(color: Colors.blueAccent),
        ),
      ],
    ),
  );
}

// TODO: CUSTOMIZEABLE INFORMATION MESSAGE

// Your information message

Future<dynamic> messageDialog(BuildContext context,
    {String icon = 'Icon.info',
    String title = 'Your Title',
    String message = 'Your Information'}) {
  return showDialog(
      context: (context),
      builder: (_) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.info,
                size: 18,
                color: Colors.blue,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                title,
                style: orderBold.copyWith(
                    fontSize: 14, color: Colors.blueAccent.withOpacity(0.8)),
              ),
            ],
          ),
          content: Text(
            message,
            style: orderRegular.copyWith(fontSize: 15, color: Colors.grey),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Done'))
          ],
        );
      });
}
