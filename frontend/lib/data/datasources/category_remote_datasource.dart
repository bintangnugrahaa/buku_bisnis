import 'package:dio/dio.dart';
import 'package:frontend/core/constants/app_constants.dart';
import 'package:frontend/data/models/response/category_response_model.dart';
import 'package:frontend/data/services/api_service.dart';

class CategoryRemoteDataSource {
  final ApiService _apiService;

  CategoryRemoteDataSource({ApiService? apiService})
    : _apiService = apiService ?? ApiService();

  /// Get all categories with optional type filter
  /// GET /api/categories
  Future<CategoryListResponseModel> getCategories({
    String? type, // income or expense
  }) async {
    try {
      final queryParameters = <String, dynamic>{};

      if (type != null && type.isNotEmpty) {
        queryParameters['type'] = type;
      }

      final response = await _apiService.get(
        AppConstants.categoriesEndpoint,
        queryParameters: queryParameters,
      );

      return CategoryListResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get category details by ID
  /// GET /api/categories/{id}
  Future<CategoryModel> getCategoryById(int id) async {
    try {
      final response = await _apiService.get(
        AppConstants.categoryDetailsEndpoint(id),
      );

      return CategoryModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create a new category
  /// POST /api/categories
  Future<CategoryCreateResponseModel> createCategory({
    required String name,
    required String type, // income or expense
    int? parentId,
  }) async {
    try {
      final data = <String, dynamic>{'name': name, 'type': type};

      if (parentId != null) {
        data['parent_id'] = parentId;
      }

      final response = await _apiService.post(
        AppConstants.categoriesEndpoint,
        data: data,
      );

      return CategoryCreateResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Update an existing category
  /// PUT /api/categories/{id}
  Future<CategoryCreateResponseModel> updateCategory({
    required int id,
    String? name,
    String? type,
    int? parentId,
  }) async {
    try {
      final data = <String, dynamic>{};

      if (name != null) data['name'] = name;
      if (type != null) data['type'] = type;
      if (parentId != null) data['parent_id'] = parentId;

      final response = await _apiService.put(
        AppConstants.categoryDetailsEndpoint(id),
        data: data,
      );

      return CategoryCreateResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Delete a category
  /// DELETE /api/categories/{id}
  Future<CategoryDeleteResponseModel> deleteCategory(int id) async {
    try {
      final response = await _apiService.delete(
        AppConstants.categoryDetailsEndpoint(id),
      );

      return CategoryDeleteResponseModel.fromJson(
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
