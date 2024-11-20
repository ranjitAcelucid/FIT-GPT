import 'package:shared_preferences/shared_preferences.dart';

/// Class containing 'SharedPreferences' instance, all data will be
/// stored/read using this class
class MySharedPref {
  // static const userType = "user_type";
  static const accessToken = "access_token";
  static const applicationIdentifierKey = "application_identifier";
  static const applicationLogoImageKey = "application_logo";
  static const userDataKey = "user_info";
  static const userEmail = "email";
  static const userPassword = "password";
  static const storeCartId = "cart_id";

  final SharedPreferences _pref;

  MySharedPref(this._pref);

  /// Save access token
  void saveAccessToken(String token) {
    _pref.setString(accessToken, token);
  }

  /// Save user email
  void saveUserEmail(String email) {
    _pref.setString(userEmail, email);
  }

  /// Save user password
  void saveUserPassword(String password) {
    _pref.setString(userPassword, password);
  }

// store local user info
  saveUserData(dynamic data) {
    _pref.setString(userDataKey, data);
  }

// store cart id
  saveCartId(int cartId) {
    _pref.setInt(storeCartId, cartId);
  }

// get user info
  getUserData() {
    return _pref.getString(userDataKey) ?? "";
  }

  /// Get access token
  String getAccessToken() {
    return _pref.getString(accessToken) ?? "";
  }

  /// Get userEmail
  String getUserEmail() {
    return _pref.getString(userEmail) ?? "";
  }

  // Get userPassword
  String getUserPsaaword() {
    return _pref.getString(userPassword) ?? "";
  }

  // Get cart id
  int? getCartId() {
    return _pref.getInt(storeCartId);
  }

  //
  void clearUserEmailPassword() {
    _pref.remove(userEmail);
    _pref.remove(userPassword);
  }

  // logout the user
  void logout() {
    _pref.remove(accessToken);
    _pref.remove(userDataKey);
    _pref.remove(storeCartId);
    // _pref.clear();
  }

// clear local cart id
  void clearCartId() {
    _pref.remove(storeCartId);
  }
}
