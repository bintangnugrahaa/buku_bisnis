import 'package:equatable/equatable.dart';
import 'package:frontend/data/models/response/category_response_model.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {
  const CategoryInitial();
}

class CategoryLoading extends CategoryState {
  const CategoryLoading();
}

class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;

  const CategoryLoaded({required this.categories});

  @override
  List<Object?> get props => [categories];
}

class CategoryDetailLoaded extends CategoryState {
  final CategoryModel category;

  const CategoryDetailLoaded({required this.category});

  @override
  List<Object?> get props => [category];
}

class CategoryOperationSuccess extends CategoryState {
  final String message;

  const CategoryOperationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class CategoryError extends CategoryState {
  final String message;

  const CategoryError({required this.message});

  @override
  List<Object?> get props => [message];
}
