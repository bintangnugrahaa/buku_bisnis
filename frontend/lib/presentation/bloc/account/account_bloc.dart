import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/services/account_service.dart';
import 'package:frontend/presentation/bloc/account/account_event.dart';
import 'package:frontend/presentation/bloc/account/account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountService _accountService;

  AccountBloc({AccountService? accountService})
    : _accountService = accountService ?? AccountService(),
      super(const AccountInitial()) {
    on<AccountLoadAll>(_onLoadAll);
    on<AccountLoadById>(_onLoadById);
    on<AccountCreate>(_onCreate);
    on<AccountUpdate>(_onUpdate);
    on<AccountDelete>(_onDelete);
    on<AccountRefresh>(_onRefresh);
  }

  Future<void> _onLoadAll(
    AccountLoadAll event,
    Emitter<AccountState> emit,
  ) async {
    emit(const AccountLoading());

    try {
      final response = await _accountService.getAccounts(
        search: event.search,
        isActive: event.isActive,
      );

      print('📊 AccountBloc: Loaded ${response.data.length} accounts');
      print('📊 AccountBloc: Total from meta: ${response.meta.total}');

      emit(AccountLoaded(accounts: response.data, total: response.meta.total));
    } catch (e, stackTrace) {
      print('❌ AccountBloc Error: $e');
      print('📍 StackTrace: $stackTrace');
      emit(AccountError(message: e.toString()));
    }
  }

  Future<void> _onLoadById(
    AccountLoadById event,
    Emitter<AccountState> emit,
  ) async {
    emit(const AccountLoading());

    try {
      final account = await _accountService.getAccountById(event.id);

      emit(AccountDetailLoaded(account: account));
    } catch (e) {
      emit(AccountError(message: e.toString()));
    }
  }

  Future<void> _onCreate(
    AccountCreate event,
    Emitter<AccountState> emit,
  ) async {
    emit(const AccountLoading());

    try {
      final response = await _accountService.createAccount(
        name: event.name,
        type: event.type,
        startingBalance: event.startingBalance,
        isActive: event.isActive,
      );

      emit(AccountOperationSuccess(message: response.message));

      // Reload accounts after creation
      add(const AccountLoadAll());
    } catch (e) {
      emit(AccountError(message: e.toString()));
    }
  }

  Future<void> _onUpdate(
    AccountUpdate event,
    Emitter<AccountState> emit,
  ) async {
    emit(const AccountLoading());

    try {
      final response = await _accountService.updateAccount(
        id: event.id,
        name: event.name,
        type: event.type,
        startingBalance: event.startingBalance,
        isActive: event.isActive,
      );

      emit(AccountOperationSuccess(message: response.message));

      // Reload accounts after update
      add(const AccountLoadAll());
    } catch (e) {
      emit(AccountError(message: e.toString()));
    }
  }

  Future<void> _onDelete(
    AccountDelete event,
    Emitter<AccountState> emit,
  ) async {
    emit(const AccountLoading());

    try {
      final response = await _accountService.deleteAccount(event.id);

      emit(AccountOperationSuccess(message: response.message));

      // Reload accounts after deletion
      add(const AccountLoadAll());
    } catch (e) {
      emit(AccountError(message: e.toString()));
    }
  }

  Future<void> _onRefresh(
    AccountRefresh event,
    Emitter<AccountState> emit,
  ) async {
    try {
      final response = await _accountService.getAccounts();

      emit(AccountLoaded(accounts: response.data, total: response.meta.total));
    } catch (e) {
      emit(AccountError(message: e.toString()));
    }
  }
}
