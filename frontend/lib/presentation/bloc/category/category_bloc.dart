import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/services/category_service.dart';
import 'package:frontend/presentation/bloc/category/category_event.dart';
import 'package:frontend/presentation/bloc/category/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryService _categoryService;

  CategoryBloc({CategoryService? categoryService})
    : _categoryService = categoryService ?? CategoryService(),
      super(const CategoryInitial()) {
    on<CategoryLoadAll>(_onLoadAll);
    on<CategoryLoadById>(_onLoadById);
    on<CategoryCreate>(_onCreate);
    on<CategoryUpdate>(_onUpdate);
    on<CategoryDelete>(_onDelete);
    on<CategoryRefresh>(_onRefresh);
  }

  Future<void> _onLoadAll(
    CategoryLoadAll event,
    Emitter<CategoryState> emit,
  ) async {
    emit(const CategoryLoading());

    try {
      final response = await _categoryService.getCategories(type: event.type);

      emit(CategoryLoaded(categories: response.data));
    } catch (e) {
      emit(CategoryError(message: e.toString()));
    }
  }

  Future<void> _onLoadById(
    CategoryLoadById event,
    Emitter<CategoryState> emit,
  ) async {
    emit(const CategoryLoading());

    try {
      final category = await _categoryService.getCategoryById(event.id);

      emit(CategoryDetailLoaded(category: category));
    } catch (e) {
      emit(CategoryError(message: e.toString()));
    }
  }

  Future<void> _onCreate(
    CategoryCreate event,
    Emitter<CategoryState> emit,
  ) async {
    emit(const CategoryLoading());

    try {
      final response = await _categoryService.createCategory(
        name: event.name,
        type: event.type,
        parentId: event.parentId,
      );

      emit(CategoryOperationSuccess(message: response.message));

      // Reload categories after creation
      add(const CategoryLoadAll());
    } catch (e) {
      emit(CategoryError(message: e.toString()));
    }
  }

  Future<void> _onUpdate(
    CategoryUpdate event,
    Emitter<CategoryState> emit,
  ) async {
    emit(const CategoryLoading());

    try {
      final response = await _categoryService.updateCategory(
        id: event.id,
        name: event.name,
        type: event.type,
        parentId: event.parentId,
      );

      emit(CategoryOperationSuccess(message: response.message));

      // Reload categories after update
      add(const CategoryLoadAll());
    } catch (e) {
      emit(CategoryError(message: e.toString()));
    }
  }

  Future<void> _onDelete(
    CategoryDelete event,
    Emitter<CategoryState> emit,
  ) async {
    emit(const CategoryLoading());

    try {
      final response = await _categoryService.deleteCategory(event.id);

      emit(CategoryOperationSuccess(message: response.message));

      // Reload categories after deletion
      add(const CategoryLoadAll());
    } catch (e) {
      emit(CategoryError(message: e.toString()));
    }
  }

  Future<void> _onRefresh(
    CategoryRefresh event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      final response = await _categoryService.getCategories();

      emit(CategoryLoaded(categories: response.data));
    } catch (e) {
      emit(CategoryError(message: e.toString()));
    }
  }
}
