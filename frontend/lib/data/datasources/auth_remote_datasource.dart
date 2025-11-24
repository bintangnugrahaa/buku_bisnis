import 'package:dio/dio.dart';
import 'package:frontend/core/constants/app_constants.dart';
import 'package:frontend/data/models/response/auth_response_model.dart';
import 'package:frontend/data/services/api_service.dart';

class AuthRemoteDataSource {
  final ApiService _apiService;

  AuthRemoteDataSource({ApiService? apiService})
    : _apiService = apiService ?? ApiService();

  /// Register a new user
  /// POST /api/auth/register
  Future<RegisterResponseModel> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await _apiService.post(
        AppConstants.registerEndpoint,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );

      return RegisterResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Login user and get auth token
  /// POST /api/auth/login
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiService.post(
        AppConstants.loginEndpoint,
        data: {'email': email, 'password': password},
      );

      final loginResponse = LoginResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      // Save token after successful login
      await _apiService.saveAuthToken(loginResponse.token);

      return loginResponse;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get current authenticated user
  /// GET /api/auth/me
  Future<GetCurrentUserResponseModel> getCurrentUser() async {
    try {
      final response = await _apiService.get(
        AppConstants.getCurrentUserEndpoint,
      );

      return GetCurrentUserResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get authenticated user (alternative endpoint)
  /// GET /api/user
  Future<UserModel> getAuthenticatedUser() async {
    try {
      final response = await _apiService.get(
        AppConstants.getAuthenticatedUserEndpoint,
      );

      return UserModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Logout user and revoke all tokens
  /// POST /api/auth/logout
  Future<LogoutResponseModel> logout() async {
    try {
      final response = await _apiService.post(AppConstants.logoutEndpoint);

      // Clear token after successful logout
      await _apiService.clearAuthToken();

      return LogoutResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Handle DioException and return appropriate error message
  String _handleError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      final data = error.response!.data;

      // Handle validation errors
      if (statusCode == 422 && data is Map<String, dynamic>) {
        if (data.containsKey('errors')) {
          final errors = data['errors'] as Map<String, dynamic>;
          final firstError = errors.values.first;
          if (firstError is List && firstError.isNotEmpty) {
            return firstError.first.toString();
          }
        }
        if (data.containsKey('message')) {
          return data['message'].toString();
        }
      }

      // Handle other errors
      if (data is Map<String, dynamic> && data.containsKey('message')) {
        return data['message'].toString();
      }

      return 'Server error: $statusCode';
    }

    // Handle network errors
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return 'Connection timeout. Please check your internet connection.';
    }

    if (error.type == DioExceptionType.connectionError) {
      return 'No internet connection. Please check your network.';
    }

    return 'An unexpected error occurred: ${error.message}';
  }
}
