import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class MySharedPrefrences {
  Future<bool?>  setBoolData({String? key, bool? value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key!, value!);
  }

   Future<bool?> getBoolData({String? key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? boolValue = prefs.getBool(key!);
    return boolValue;
  }

  static Future<String?> getStringData({String? key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? data = prefs.getString(key!);
    return data;
  }



  static setStringData({String? key, String? value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key!, value!.toString());
  }

  clearData({String? key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key!);
  }

  static Future<void> saveJsonData(
      {required String key, required String jsonData}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonData);
  }

// Function to retrieve JSON data from SharedPreferences
  static getJsonData({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(key);
    if (jsonString != null) {
      return json.decode(jsonString);
    } else {
      return null;
    }
  }

  static clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
