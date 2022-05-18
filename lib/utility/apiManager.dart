import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  BuildContext context;

  ApiManager(BuildContext context) {
    this.context = context;
  }

  static Future<bool> checkInternet() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  postCall({@required String url, @required Map request}) async {
    http.Response response = await http.post(Uri.parse(url), body: request);
    return await json.decode(response.body);
  }

  deleteCall({@required String url}) async {
    http.Response response = await http.delete(Uri.parse(url));
    return await jsonDecode(response.body);
  }

  getCall(
      {@required String url, @required Map<String, dynamic> request}) async {
    var uri = Uri.parse(url);
    uri = uri.replace(queryParameters: request);
    http.Response response = await http.get(uri);
    return await jsonDecode(response.body);
  }
}
