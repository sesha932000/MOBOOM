import 'dart:convert';

import 'package:flutter_project_interview/Model/cartModel.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static Future<CartModel> getProdcts() async {
    // var client = http.Client();
    try {
      var response = await http.get(
        Uri.parse('https://dummyjson.com/products'),
      );
      // print(response.body);
      var decodedResponse = json.decode(response.body);
      CartModel data = CartModel.fromJson(decodedResponse);
      return data;
    } finally {
      // http.close();
    }
  }

  static Future<List> categories() async {
    // var client = http.Client();
    try {
      var response = await http.get(
        Uri.parse('https://dummyjson.com/products/categories'),
      );
      print(response.body);
      var decodedResponse = json.decode(response.body);

      return decodedResponse;
    } finally {
      // http.close();
    }
  }

  static Future<CartModel> getProdecsbycategories(String catagre) async {
    // var client = http.Client();
    try {
      var response = await http.get(
        Uri.parse("https://dummyjson.com/products/search?q=$catagre"),
      );
      print(response.body);
      var decodedResponse = json.decode(response.body);
      CartModel data = CartModel.fromJson(decodedResponse);
      return data;
    } finally {
      // http.close();
    }
  }
}
