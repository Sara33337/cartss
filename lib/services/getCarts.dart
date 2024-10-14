import 'dart:convert';

import 'package:cartapp/models/CartModel.dart';
import 'package:http/http.dart' as http;

class GetAllCarts {
  Future<List<CartModel>> getCarts() async {
    http.Response response =
        await http.get(Uri.parse("https://dummyjson.com/carts"));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      List<dynamic> cartData = responseData['carts'];

      List<CartModel> cartList = [];

     for (int i = 0; i < 20 ; i++) {
        cartList.add(CartModel.fromJson(cartData[i]));
      }

      return cartList;
    } else {
      throw Exception("Error: ${response.statusCode}");
    }
  }
}
