import 'package:equatable/equatable.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object?> get props => [];
}

class TransactionLoadAll extends TransactionEvent {
  final int? accountId;
  final int? categoryId;
  final String? type;
  final String? fromDate;
  final String? toDate;
  final String? search;
  final double? minAmount;
  final double? maxAmount;
  final String sortBy;
  final String sortOrder;
  final int perPage;
  final int page;

  const TransactionLoadAll({
    this.accountId,
    this.categoryId,
    this.type,
    this.fromDate,
    this.toDate,
    this.search,
    this.minAmount,
    this.maxAmount,
    this.sortBy = 'date',
    this.sortOrder = 'desc',
    this.perPage = 15,
    this.page = 1,
  });

  @override
  List<Object?> get props => [
        accountId,
        categoryId,
        type,
        fromDate,
        toDate,
        search,
        minAmount,
        maxAmount,
        sortBy,
        sortOrder,
        perPage,
        page,
      ];
}

class TransactionLoadById extends TransactionEvent {
  final int id;

  const TransactionLoadById({required this.id});

  @override
  List<Object?> get props => [id];
}

class TransactionCreate extends TransactionEvent {
  final int accountId;
  final int categoryId;
  final String type;
  final String date;
  final double amount;
  final String? note;
  final String? counterparty;

  const TransactionCreate({
    required this.accountId,
    required this.categoryId,
    required this.type,
    required this.date,
    required this.amount,
    this.note,
    this.counterparty,
  });

  @override
  List<Object?> get props => [
        accountId,
        categoryId,
        type,
        date,
        amount,
        note,
        counterparty,
      ];
}

class TransactionUpdate extends TransactionEvent {
  final int id;
  final int? accountId;
  final int? categoryId;
  final String? type;
  final String? date;
  final double? amount;
  final String? note;
  final String? counterparty;

  const TransactionUpdate({
    required this.id,
    this.accountId,
    this.categoryId,
    this.type,
    this.date,
    this.amount,
    this.note,
    this.counterparty,
  });

  @override
  List<Object?> get props => [
        id,
        accountId,
        categoryId,
        type,
        date,
        amount,
        note,
        counterparty,
      ];
}

class TransactionDelete extends TransactionEvent {
  final int id;

  const TransactionDelete({required this.id});

  @override
  List<Object?> get props => [id];
}

class TransactionCreateTransfer extends TransactionEvent {
  final int fromAccountId;
  final int toAccountId;
  final double amount;
  final String date;
  final String? note;

  const TransactionCreateTransfer({
    required this.fromAccountId,
    required this.toAccountId,
    required this.amount,
    required this.date,
    this.note,
  });

  @override
  List<Object?> get props => [
        fromAccountId,
        toAccountId,
        amount,
        date,
        note,
      ];
}

class TransactionLoadStatistics extends TransactionEvent {
  final String? fromDate;
  final String? toDate;
  final int? accountId;
  final int? categoryId;

  const TransactionLoadStatistics({
    this.fromDate,
    this.toDate,
    this.accountId,
    this.categoryId,
  });

  @override
  List<Object?> get props => [fromDate, toDate, accountId, categoryId];
}

class TransactionRefresh extends TransactionEvent {
  const TransactionRefresh();
}
