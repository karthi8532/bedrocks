import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static late SharedPreferences _prefs;

  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  //sets
  static Future<bool> setLoggedIn(String key, bool value) async =>
      await _prefs.setBool(key, value);

  static Future<bool> setToken(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setTokenNetsuite(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setFullName(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setUniqId(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setdesignation(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setEmail(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setNsID(String key, int value) async =>
      await _prefs.setInt(key, value);

  static Future<bool> setEmpID(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setUserName(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setEmailid(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setDesignation(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setImageURL(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setMobPassword(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setShiftName(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setShiftFromTime(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setShiftToTime(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setMobileNo(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setLinemanager(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setSupervisor(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> sethod(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setDeviceName(String key, String value) async =>
      await _prefs.setString(key, value);
  static Future<bool> setDeviceVersion(String key, String value) async =>
      await _prefs.setString(key, value);
  static Future<bool> setDeviceIdnetifier(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setLogonTime(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setWorkRegion(String key, String value) async =>
      await _prefs.setString(key, value);

  //getsuserName
  static bool? getLoggedIn(String key) => _prefs.getBool(key);

  static String? getToken(String key) => _prefs.getString(key);

  static String? getTokenNetsuite(String key) => _prefs.getString(key);

  static String? getFullName(String key) => _prefs.getString(key);

  static int? getNsID(String key) => _prefs.getInt(key);

  static String? getEmpID(String key) => _prefs.getString(key);

  static String? getUniqId(String key) => _prefs.getString(key);

  static String? getdesignation(String key) => _prefs.getString(key);

  static String? getEmail(String key) => _prefs.getString(key);

  static String? getUserName(String key) => _prefs.getString(key);

  static String? getEmailid(String key) => _prefs.getString(key);
  static String? getDesignation(String key) => _prefs.getString(key);

  static String? getImageURL(String key) => _prefs.getString(key);
  static String? getMobPassword(String key) => _prefs.getString(key);

  static String? getShiftName(String key) => _prefs.getString(key);
  static String? getShiftFromTime(String key) => _prefs.getString(key);
  static String? getShiftToTime(String key) => _prefs.getString(key);
  static String? getMobileNo(String key) => _prefs.getString(key);
  static String? getLinemanager(String key) => _prefs.getString(key);
  static String? getSupervisor(String key) => _prefs.getString(key);
  static String? gethod(String key) => _prefs.getString(key);

  static String? getDeviceName(String key) => _prefs.getString(key);
  static String? getDeviceVersion(String key) => _prefs.getString(key);
  static String? getDeviceIdnetifier(String key) => _prefs.getString(key);

  static String? getLogonTime(String key) => _prefs.getString(key);
  static String? getWorkRegion(String key) => _prefs.getString(key);

  //deletes..
  static Future<bool> remove(String key) async => await _prefs.remove(key);

  static Future<bool> clear() async => await _prefs.clear();
}
