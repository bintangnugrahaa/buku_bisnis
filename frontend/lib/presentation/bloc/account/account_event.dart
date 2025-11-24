import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object?> get props => [];
}

class AccountLoadAll extends AccountEvent {
  final String? search;
  final bool? isActive;

  const AccountLoadAll({
    this.search,
    this.isActive,
  });

  @override
  List<Object?> get props => [search, isActive];
}

class AccountLoadById extends AccountEvent {
  final int id;

  const AccountLoadById({required this.id});

  @override
  List<Object?> get props => [id];
}

class AccountCreate extends AccountEvent {
  final String name;
  final String type;
  final double startingBalance;
  final bool isActive;

  const AccountCreate({
    required this.name,
    required this.type,
    required this.startingBalance,
    this.isActive = true,
  });

  @override
  List<Object?> get props => [name, type, startingBalance, isActive];
}

class AccountUpdate extends AccountEvent {
  final int id;
  final String? name;
  final String? type;
  final double? startingBalance;
  final bool? isActive;

  const AccountUpdate({
    required this.id,
    this.name,
    this.type,
    this.startingBalance,
    this.isActive,
  });

  @override
  List<Object?> get props => [id, name, type, startingBalance, isActive];
}

class AccountDelete extends AccountEvent {
  final int id;

  const AccountDelete({required this.id});

  @override
  List<Object?> get props => [id];
}

class AccountRefresh extends AccountEvent {
  const AccountRefresh();
}
