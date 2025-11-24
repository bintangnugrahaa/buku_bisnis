import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/services/transaction_service.dart';
import 'package:frontend/presentation/bloc/transaction/transaction_event.dart';
import 'package:frontend/presentation/bloc/transaction/transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionService _transactionService;

  TransactionBloc({TransactionService? transactionService})
    : _transactionService = transactionService ?? TransactionService(),
      super(const TransactionInitial()) {
    on<TransactionLoadAll>(_onLoadAll);
    on<TransactionLoadById>(_onLoadById);
    on<TransactionCreate>(_onCreate);
    on<TransactionUpdate>(_onUpdate);
    on<TransactionDelete>(_onDelete);
    on<TransactionCreateTransfer>(_onCreateTransfer);
    on<TransactionLoadStatistics>(_onLoadStatistics);
    on<TransactionRefresh>(_onRefresh);
  }

  Future<void> _onLoadAll(
    TransactionLoadAll event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoading());

    try {
      final response = await _transactionService.getTransactions(
        accountId: event.accountId,
        categoryId: event.categoryId,
        type: event.type,
        fromDate: event.fromDate,
        toDate: event.toDate,
        search: event.search,
        minAmount: event.minAmount,
        maxAmount: event.maxAmount,
        sortBy: event.sortBy,
        sortOrder: event.sortOrder,
        perPage: event.perPage,
        page: event.page,
      );

      emit(
        TransactionLoaded(
          transactions: response.data,
          pagination: response.pagination,
        ),
      );
    } catch (e) {
      emit(TransactionError(message: e.toString()));
    }
  }

  Future<void> _onLoadById(
    TransactionLoadById event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoading());

    try {
      final transaction = await _transactionService.getTransactionById(
        event.id,
      );

      emit(TransactionDetailLoaded(transaction: transaction));
    } catch (e) {
      emit(TransactionError(message: e.toString()));
    }
  }

  Future<void> _onCreate(
    TransactionCreate event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoading());

    try {
      final response = await _transactionService.createTransaction(
        accountId: event.accountId,
        categoryId: event.categoryId,
        type: event.type,
        date: event.date,
        amount: event.amount,
        note: event.note,
        counterparty: event.counterparty,
      );

      emit(TransactionOperationSuccess(message: response.message));

      // Reload transactions after creation
      add(const TransactionLoadAll());
    } catch (e) {
      emit(TransactionError(message: e.toString()));
    }
  }

  Future<void> _onUpdate(
    TransactionUpdate event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoading());

    try {
      final response = await _transactionService.updateTransaction(
        id: event.id,
        accountId: event.accountId,
        categoryId: event.categoryId,
        type: event.type,
        date: event.date,
        amount: event.amount,
        note: event.note,
        counterparty: event.counterparty,
      );

      emit(TransactionOperationSuccess(message: response.message));

      // Reload transactions after update
      add(const TransactionLoadAll());
    } catch (e) {
      emit(TransactionError(message: e.toString()));
    }
  }

  Future<void> _onDelete(
    TransactionDelete event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoading());

    try {
      final response = await _transactionService.deleteTransaction(event.id);

      emit(TransactionOperationSuccess(message: response.message));

      // Reload transactions after deletion
      add(const TransactionLoadAll());
    } catch (e) {
      emit(TransactionError(message: e.toString()));
    }
  }

  Future<void> _onCreateTransfer(
    TransactionCreateTransfer event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoading());

    try {
      final response = await _transactionService.createTransfer(
        fromAccountId: event.fromAccountId,
        toAccountId: event.toAccountId,
        amount: event.amount,
        date: event.date,
        note: event.note,
      );

      emit(TransactionOperationSuccess(message: response.message));

      // Reload transactions after transfer creation
      add(const TransactionLoadAll());
    } catch (e) {
      emit(TransactionError(message: e.toString()));
    }
  }

  Future<void> _onLoadStatistics(
    TransactionLoadStatistics event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoading());

    try {
      final response = await _transactionService.getTransactionStatistics(
        fromDate: event.fromDate,
        toDate: event.toDate,
        accountId: event.accountId,
        categoryId: event.categoryId,
      );

      emit(TransactionStatisticsLoaded(statistics: response.data));
    } catch (e) {
      emit(TransactionError(message: e.toString()));
    }
  }

  Future<void> _onRefresh(
    TransactionRefresh event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      final response = await _transactionService.getTransactions();

      emit(
        TransactionLoaded(
          transactions: response.data,
          pagination: response.pagination,
        ),
      );
    } catch (e) {
      emit(TransactionError(message: e.toString()));
    }
  }
}
