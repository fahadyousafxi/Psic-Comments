import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiController {
  final _fireStore = FirebaseFirestore.instance.collection("users");

  apply({var name, var comment, var hall, var secretKey, context, data}) async {
    var jsonObject = {
      'name': name,
      'comment': comment,
      'hall': hall,
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
        const SnackBar(
          content: Text('Message Sent Successfully'),
        ),
      );

      Timer(const Duration(seconds: 20), () {
        _fireStore.doc(data).delete();
      });

      return jsonDecode(response.body)['result'];
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sending Failed'),
        ),
      );

      print('********************************');
      print(response.statusCode);
      print('********************************');

      return jsonDecode(response.body)['result'];
    }
  }
}
