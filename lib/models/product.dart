import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Product {
  int id;
  String name, type, desc, location, imageUrl, wifiReady;
  int numberOfBed, numberOfBath, numberOfKitchen;
  int qty, price;
  String owner, ownerPhone;

  Product(
      {this.id,
      this.name,
      this.type,
      this.desc,
      this.location,
      this.imageUrl,
      this.wifiReady,
      this.numberOfBed,
      this.numberOfBath,
      this.numberOfKitchen,
      this.qty,
      this.price,
      this.owner,
      this.ownerPhone});

  factory Product.fromJson(Map<String, dynamic> object) {
    return Product(
        id: object['kost_id'],
        name: object['kost_name'],
        type: object['kost_type'],
        desc: object['kost_desc'],
        location: object['kost_location'],
        imageUrl: object['kost_images'],
        wifiReady: object['kost_wifi_ready'],
        numberOfBed: object['kost_master_bed'],
        numberOfBath: object['kost_bathrooms'],
        numberOfKitchen: object['kost_kitchen'],
        qty: object['kost_stock'],
        price: object['kost_price_per_month'],
        owner: object['kost_owner'],
        ownerPhone: object['kost_owner_phone']);
  }

  static Future<List<Product>> getProduct({String name = ''}) async {
    String url =
        'https://apikost.000webhostapp.com/api/kost/list.php?kost_name=' + name;

    var result = await http.get(Uri.parse(url));

    if (result.statusCode == 200) {
      var jsonObject = json.decode(result.body);
      List<dynamic> listProduct =
          (jsonObject as Map<String, dynamic>)['result'];

      List<Product> product = [];
      for (var i = 0; i < listProduct.length; i++)
        product.add(Product.fromJson(listProduct[i]));

      return product;
    } else {
      throw Exception('Failed to load product');
    }
  }

  static Future<Product> getProductById(int id) async {
    String url = 'https://apikost.000webhostapp.com/api/kost/list.php?id=' +
        id.toString();

    var result = await http.get(Uri.parse(url));

    if (result.statusCode == 200) {
      var jsonObject = json.decode(result.body);
      var listProduct = (jsonObject as Map<String, dynamic>)['result'];

      List<Product> product = [];
      product.add(Product.fromJson(listProduct[0]));

      return product[0];
    } else {
      throw Exception('Failed to get product');
    }
  }
}
