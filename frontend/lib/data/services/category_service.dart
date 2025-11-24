import 'package:frontend/data/datasources/category_remote_datasource.dart';
import 'package:frontend/data/models/response/category_response_model.dart';

class CategoryService {
  final CategoryRemoteDataSource _remoteDataSource;

  CategoryService({CategoryRemoteDataSource? remoteDataSource})
    : _remoteDataSource = remoteDataSource ?? CategoryRemoteDataSource();

  /// Get all categories with optional type filter
  Future<CategoryListResponseModel> getCategories({String? type}) async {
    return await _remoteDataSource.getCategories(type: type);
  }

  /// Get category details by ID
  Future<CategoryModel> getCategoryById(int id) async {
    return await _remoteDataSource.getCategoryById(id);
  }

  /// Create a new category
  Future<CategoryCreateResponseModel> createCategory({
    required String name,
    required String type,
    int? parentId,
  }) async {
    return await _remoteDataSource.createCategory(
      name: name,
      type: type,
      parentId: parentId,
    );
  }

  /// Update an existing category
  Future<CategoryCreateResponseModel> updateCategory({
    required int id,
    String? name,
    String? type,
    int? parentId,
  }) async {
    return await _remoteDataSource.updateCategory(
      id: id,
      name: name,
      type: type,
      parentId: parentId,
    );
  }

  /// Delete a category
  Future<CategoryDeleteResponseModel> deleteCategory(int id) async {
    return await _remoteDataSource.deleteCategory(id);
  }
}
