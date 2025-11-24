import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

class CategoryLoadAll extends CategoryEvent {
  final String? type; // income or expense

  const CategoryLoadAll({this.type});

  @override
  List<Object?> get props => [type];
}

class CategoryLoadById extends CategoryEvent {
  final int id;

  const CategoryLoadById({required this.id});

  @override
  List<Object?> get props => [id];
}

class CategoryCreate extends CategoryEvent {
  final String name;
  final String type; // income or expense
  final int? parentId;

  const CategoryCreate({
    required this.name,
    required this.type,
    this.parentId,
  });

  @override
  List<Object?> get props => [name, type, parentId];
}

class CategoryUpdate extends CategoryEvent {
  final int id;
  final String? name;
  final String? type;
  final int? parentId;

  const CategoryUpdate({
    required this.id,
    this.name,
    this.type,
    this.parentId,
  });

  @override
  List<Object?> get props => [id, name, type, parentId];
}

class CategoryDelete extends CategoryEvent {
  final int id;

  const CategoryDelete({required this.id});

  @override
  List<Object?> get props => [id];
}

class CategoryRefresh extends CategoryEvent {
  const CategoryRefresh();
}
