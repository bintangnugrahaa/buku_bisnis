import 'package:equatable/equatable.dart';
import 'package:frontend/data/models/response/account_response_model.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object?> get props => [];
}

class AccountInitial extends AccountState {
  const AccountInitial();
}

class AccountLoading extends AccountState {
  const AccountLoading();
}

class AccountLoaded extends AccountState {
  final List<AccountModel> accounts;
  final int total;

  const AccountLoaded({required this.accounts, required this.total});

  @override
  List<Object?> get props => [accounts, total];
}

class AccountDetailLoaded extends AccountState {
  final AccountModel account;

  const AccountDetailLoaded({required this.account});

  @override
  List<Object?> get props => [account];
}

class AccountOperationSuccess extends AccountState {
  final String message;

  const AccountOperationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class AccountError extends AccountState {
  final String message;

  const AccountError({required this.message});

  @override
  List<Object?> get props => [message];
}
