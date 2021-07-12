import 'package:flutter/material.dart';
import '../order_summary_row.dart';
import '../../theme.dart';
import 'package:intl/intl.dart';
import '../../models/product.dart';

class OrderSummaryDetails extends StatefulWidget {
  const OrderSummaryDetails({
    Key key,
    @required this.data,
    @required this.currencyFormat,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final NumberFormat currencyFormat;

  @override
  _OrderSummaryDetailsState createState() => _OrderSummaryDetailsState();
}

class _OrderSummaryDetailsState extends State<OrderSummaryDetails> {
  String img = "https://via.placeholder.com/150";
  String kostName = "Product name";
  String type = "Product type";
  String owner = "Product owner";
  String phone = "Product owner phone";
  int price = 0;

  @override
  void initState() {
    super.initState();
    getKost(widget.data['kostID']).then((value) {
      setState(() {
        kostName = value.name;
        img = value.imageUrl;
        type = value.type;
        owner = value.owner;
        phone = value.ownerPhone;
        price = value.price;
      });
    });
  }

  Future<Product> getKost(int id) async {
    var productById = await Product.getProductById(id);
    return productById;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order summary',
            style: orderBold.copyWith(color: orderBlack),
          ),

          SizedBox(
            height: 10,
          ),

          // Kost image and details

          Row(
            children: [
              Image.network(
                img ?? 'https://via.placeholder.com/150',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    child: Text(
                      kostName ?? "name",
                      maxLines: 4,
                      style: orderRegular.copyWith(color: orderBlack),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    type ?? "type",
                    style: orderLight.copyWith(
                        fontSize: 12, color: Color(0xffA5A5A5)),
                  ),
                ],
              )
            ],
          ),

          SizedBox(
            height: 22,
          ),
          Divider(
            color: Color(0xffd8d8d8),
          ),
          SizedBox(
            height: 10,
          ),

          // Order Details

          OrderRow(
            title: 'Owner',
            value: owner,
          ),
          OrderRow(
            title: 'Phone',
            value: phone, // kost owner phone
          ),

          Divider(
            color: Color(0xffd8d8d8),
          ),

          SizedBox(
            height: 10,
          ),
          OrderRow(title: 'Customer', value: '${widget.data['customer_name']}'),
          OrderRow(
              title: 'Rent Month',
              value: '${widget.data['long_rented']} Months'),
          OrderRow(
            title: 'Rental Price /month',
            value: 'IDR ${widget.currencyFormat.format(price) ?? 0}',
          ),
          OrderRow(
            title: 'Total Price',
            value:
                'IDR ${widget.currencyFormat.format(widget.data['total']) ?? 0}',
          ),
          OrderRow(
            title: 'Phone',
            value: widget.data['phone'], // customer phone
          ),
          OrderRow(
            title: 'Tax',
            value:
                'IDR ${widget.currencyFormat.format(widget.data['total'] * 0.1) ?? 0}' +
                    ' (10%)',
          ),
          OrderRow(
            title: 'Payment Method',
            value: (widget.data['payment'] == 'unregistered')
                ? 'Choose Payment'
                : widget.data['payment'],
          ),
          OrderRow(
            title: 'Payment Status',
            value: widget.data['paid'],
            isPaymentStatus: true,
          ),
          Divider(
            color: Color(0xffd8d8d8),
          ),
          SizedBox(
            height: 15,
          ),
          OrderRow(
            title: 'Total',
            value:
                'IDR ${widget.currencyFormat.format(widget.data['total'] + (widget.data['total'] * 0.1)) ?? 0}',
            isTotal: true,
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
