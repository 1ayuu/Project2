import 'dart:convert';

import 'package:fragrance_for_you/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:fragrance_for_you/features/address/screens/address_screen.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']);
      if (ModalRoute.of(context)!.settings.name == AddressScreen.routeName) {
        Navigator.pop(context);
      }
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}
