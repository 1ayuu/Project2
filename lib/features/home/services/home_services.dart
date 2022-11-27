import 'dart:convert';

import 'package:fragrance_for_you/constants/error_handling.dart';
import 'package:fragrance_for_you/constants/global_variables.dart';
import 'package:fragrance_for_you/constants/utils.dart';
import 'package:fragrance_for_you/models/product.dart';
import 'package:fragrance_for_you/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  Future<List<Product>> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products?category=$category'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<List<Product>> fetchDealOfDay({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    // Product product = Product(
    //   name: '',
    //   description: '',
    //   quantity: 0,
    //   images: [],
    //   category: '',
    //   price: 0,
    // );
    List<Product> product = [];

    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/deal-of-day'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          print(jsonDecode(res.body).length);
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            product.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
          // res.body.isEmpty
          //     ? product = []
          //     : product
          //         .addAll(jsonDecode(res.body).map((e) => Product.fromJson(e)));
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return product;
  }
}
