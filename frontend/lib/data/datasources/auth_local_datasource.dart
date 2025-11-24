import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/core/constants/app_constants.dart';
import 'package:frontend/data/models/response/auth_response_model.dart';

class AuthLocalDataSource {
  /// Save user data to local storage
  Future<void> saveUserData(UserModel user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        AppConstants.userDataKey,
        jsonEncode(user.toJson()),
      );
    } catch (e) {
      throw Exception('Failed to save user data: $e');
    }
  }

  /// Get user data from local storage
  Future<UserModel?> getUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userDataString = prefs.getString(AppConstants.userDataKey);

      if (userDataString != null && userDataString.isNotEmpty) {
        final userDataJson = jsonDecode(userDataString) as Map<String, dynamic>;
        return UserModel.fromJson(userDataJson);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user data: $e');
    }
  }

  /// Clear all auth data from local storage
  Future<void> clearAuthData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(AppConstants.accessTokenKey);
      await prefs.remove(AppConstants.refreshTokenKey);
      await prefs.remove(AppConstants.userDataKey);
    } catch (e) {
      throw Exception('Failed to clear auth data: $e');
    }
  }

  /// Check if user is logged in (has valid token)
  Future<bool> isLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(AppConstants.accessTokenKey);
      return token != null && token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Save auth token to local storage
  Future<void> saveAuthToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.accessTokenKey, token);
    } catch (e) {
      throw Exception('Failed to save auth token: $e');
    }
  }

  /// Get auth token from local storage
  Future<String?> getAuthToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(AppConstants.accessTokenKey);
    } catch (e) {
      return null;
    }
  }

  /// Save refresh token to local storage
  Future<void> saveRefreshToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.refreshTokenKey, token);
    } catch (e) {
      throw Exception('Failed to save refresh token: $e');
    }
  }

  /// Get refresh token from local storage
  Future<String?> getRefreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(AppConstants.refreshTokenKey);
    } catch (e) {
      return null;
    }
  }
}
