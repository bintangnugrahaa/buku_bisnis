import 'package:dio/dio.dart';
import 'package:frontend/core/constants/app_constants.dart';
import 'package:frontend/data/models/response/account_response_model.dart';
import 'package:frontend/data/services/api_service.dart';

class AccountRemoteDataSource {
  final ApiService _apiService;

  AccountRemoteDataSource({ApiService? apiService})
    : _apiService = apiService ?? ApiService();

  /// Get all accounts with optional filters
  /// GET /api/accounts
  Future<AccountListResponseModel> getAccounts({
    String? search,
    bool? isActive,
  }) async {
    try {
      final queryParameters = <String, dynamic>{};

      if (search != null && search.isNotEmpty) {
        queryParameters['q'] = search;
      }
      if (isActive != null) {
        // Send as boolean directly - Laravel should handle it
        queryParameters['is_active'] = isActive;
      }

      print('🔍 AccountRemoteDataSource: Query params: $queryParameters');
      print('🔍 is_active value: $isActive (type: ${isActive.runtimeType})');

      final response = await _apiService.get(
        AppConstants.accountsEndpoint,
        queryParameters: queryParameters,
      );

      print(
        '✅ AccountRemoteDataSource: Response status ${response.statusCode}',
      );
      print('✅ Response data type: ${response.data.runtimeType}');

      return AccountListResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      print('❌ AccountRemoteDataSource: DioException ${e.message}');
      print('❌ Response: ${e.response?.data}');
      throw _handleError(e);
    } catch (e, stackTrace) {
      print('❌ AccountRemoteDataSource: Unexpected error $e');
      print('❌ StackTrace: $stackTrace');
      rethrow;
    }
  }

  /// Get account details by ID
  /// GET /api/accounts/{id}
  Future<AccountModel> getAccountById(int id) async {
    try {
      final response = await _apiService.get(
        AppConstants.accountDetailsEndpoint(id),
      );

      return AccountModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create a new account
  /// POST /api/accounts
  Future<AccountCreateResponseModel> createAccount({
    required String name,
    required String type,
    required double startingBalance,
    bool isActive = true,
  }) async {
    try {
      final response = await _apiService.post(
        AppConstants.accountsEndpoint,
        data: {
          'name': name,
          'type': type,
          'starting_balance': startingBalance,
          'is_active': isActive,
        },
      );

      return AccountCreateResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Update an existing account
  /// PUT /api/accounts/{id}
  Future<AccountCreateResponseModel> updateAccount({
    required int id,
    String? name,
    String? type,
    double? startingBalance,
    bool? isActive,
  }) async {
    try {
      final data = <String, dynamic>{};

      if (name != null) data['name'] = name;
      if (type != null) data['type'] = type;
      if (startingBalance != null) data['starting_balance'] = startingBalance;
      if (isActive != null) data['is_active'] = isActive;

      final response = await _apiService.put(
        AppConstants.accountDetailsEndpoint(id),
        data: data,
      );

      return AccountCreateResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Delete an account
  /// DELETE /api/accounts/{id}
  Future<AccountDeleteResponseModel> deleteAccount(int id) async {
    try {
      final response = await _apiService.delete(
        AppConstants.accountDetailsEndpoint(id),
      );

      return AccountDeleteResponseModel.fromJson(
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
