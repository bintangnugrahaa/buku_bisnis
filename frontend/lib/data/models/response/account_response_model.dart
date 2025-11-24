class AccountModel {
  final int id;
  final int userId;
  final String name;
  final String type;
  final String startingBalance;
  final bool isActive;
  final String createdAt;
  final String updatedAt;

  AccountModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    required this.startingBalance,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      startingBalance: json['starting_balance'].toString(),
      isActive: json['is_active'] as bool,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'type': type,
      'starting_balance': startingBalance,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class AccountListResponseModel {
  final List<AccountModel> data;
  final AccountMetaModel meta;

  AccountListResponseModel({required this.data, required this.meta});

  factory AccountListResponseModel.fromJson(Map<String, dynamic> json) {
    return AccountListResponseModel(
      data: (json['data'] as List)
          .map((e) => AccountModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: AccountMetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
      'meta': meta.toJson(),
    };
  }
}

class AccountMetaModel {
  final int total;
  final AccountFiltersModel filtersApplied;

  AccountMetaModel({required this.total, required this.filtersApplied});

  factory AccountMetaModel.fromJson(Map<String, dynamic> json) {
    return AccountMetaModel(
      total: json['total'] as int,
      filtersApplied: AccountFiltersModel.fromJson(
        json['filters_applied'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'total': total, 'filters_applied': filtersApplied.toJson()};
  }
}

class AccountFiltersModel {
  final String? search;
  final bool? isActive;

  AccountFiltersModel({this.search, this.isActive});

  factory AccountFiltersModel.fromJson(Map<String, dynamic> json) {
    // Parse is_active - backend might send as string "true"/"false" or boolean
    bool? isActive;
    final isActiveValue = json['is_active'];
    if (isActiveValue != null) {
      if (isActiveValue is bool) {
        isActive = isActiveValue;
      } else if (isActiveValue is String) {
        isActive = isActiveValue.toLowerCase() == 'true';
      } else if (isActiveValue is int) {
        isActive = isActiveValue == 1;
      }
    }

    return AccountFiltersModel(
      search: json['search'] as String?,
      isActive: isActive,
    );
  }

  Map<String, dynamic> toJson() {
    return {'search': search, 'is_active': isActive};
  }
}

class AccountCreateResponseModel {
  final String message;
  final AccountModel data;

  AccountCreateResponseModel({required this.message, required this.data});

  factory AccountCreateResponseModel.fromJson(Map<String, dynamic> json) {
    return AccountCreateResponseModel(
      message: json['message'] as String,
      data: AccountModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data.toJson()};
  }
}

class AccountDeleteResponseModel {
  final String message;

  AccountDeleteResponseModel({required this.message});

  factory AccountDeleteResponseModel.fromJson(Map<String, dynamic> json) {
    return AccountDeleteResponseModel(message: json['message'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}
