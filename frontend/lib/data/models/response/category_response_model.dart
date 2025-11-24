class CategoryModel {
  final int id;
  final int userId;
  final String name;
  final String type;
  final int? parentId;
  final String createdAt;
  final String updatedAt;
  final CategoryModel? parent;
  final List<CategoryModel>? children;

  CategoryModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    this.parentId,
    required this.createdAt,
    required this.updatedAt,
    this.parent,
    this.children,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      parentId: json['parent_id'] as int?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      parent: json['parent'] != null
          ? CategoryModel.fromJson(json['parent'] as Map<String, dynamic>)
          : null,
      children: json['children'] != null
          ? (json['children'] as List)
              .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'type': type,
      'parent_id': parentId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'parent': parent?.toJson(),
      'children': children?.map((e) => e.toJson()).toList(),
    };
  }
}

class CategoryListResponseModel {
  final String message;
  final List<CategoryModel> data;

  CategoryListResponseModel({
    required this.message,
    required this.data,
  });

  factory CategoryListResponseModel.fromJson(Map<String, dynamic> json) {
    return CategoryListResponseModel(
      message: json['message'] as String,
      data: (json['data'] as List)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class CategoryCreateResponseModel {
  final String message;
  final CategoryModel data;

  CategoryCreateResponseModel({
    required this.message,
    required this.data,
  });

  factory CategoryCreateResponseModel.fromJson(Map<String, dynamic> json) {
    return CategoryCreateResponseModel(
      message: json['message'] as String,
      data: CategoryModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class CategoryDeleteResponseModel {
  final String message;

  CategoryDeleteResponseModel({
    required this.message,
  });

  factory CategoryDeleteResponseModel.fromJson(Map<String, dynamic> json) {
    return CategoryDeleteResponseModel(
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}
