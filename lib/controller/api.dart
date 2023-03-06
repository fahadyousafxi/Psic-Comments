import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiController {
  apply({var name, var comment, var secretKey, context}) async {
    var jsonObject = {
      'name': name,
      'comment': comment,
      'secretkey': secretKey,
    };

    var jsonString = jsonEncode(jsonObject);

    final url = Uri.parse('https://psic.org.pk/aic.php');
    var response = await http.post(
      url,
      body: jsonDecode(jsonString),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(jsonDecode(response.body)['result']),
        ),
      );

      return jsonDecode(response.body)['result'];
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(jsonDecode(response.body)['result']),
        ),
      );

      return jsonDecode(response.body)['result'];
    }
  }
}
