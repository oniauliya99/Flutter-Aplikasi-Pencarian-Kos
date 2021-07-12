import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme.dart';

class Tenant extends StatelessWidget {
  const Tenant({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/user_pic2.png'),
        ),
        title: Text(
          "Irfan harfiansyah",
          style: orderSemiBold.copyWith(fontSize: 16),
        ),
        subtitle: Text(
          "mantap jiwaaa",
          style: orderLight.copyWith(fontSize: 14),
        ),
        trailing: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text("5/5", style: orderSemiBold.copyWith(fontSize: 14)),
            SizedBox(
              width: 10,
            ),
            SvgPicture.asset('assets/svg/Vector.svg')
          ],
        ),
      ),
    );
  }
}