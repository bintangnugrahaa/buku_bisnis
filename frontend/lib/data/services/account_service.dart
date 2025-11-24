import 'package:frontend/data/datasources/account_remote_datasource.dart';
import 'package:frontend/data/models/response/account_response_model.dart';

class AccountService {
  final AccountRemoteDataSource _remoteDataSource;

  AccountService({AccountRemoteDataSource? remoteDataSource})
    : _remoteDataSource = remoteDataSource ?? AccountRemoteDataSource();

  /// Get all accounts with optional filters
  Future<AccountListResponseModel> getAccounts({
    String? search,
    bool? isActive,
  }) async {
    return await _remoteDataSource.getAccounts(
      search: search,
      isActive: isActive,
    );
  }

  /// Get account details by ID
  Future<AccountModel> getAccountById(int id) async {
    return await _remoteDataSource.getAccountById(id);
  }

  /// Create a new account
  Future<AccountCreateResponseModel> createAccount({
    required String name,
    required String type,
    required double startingBalance,
    bool isActive = true,
  }) async {
    return await _remoteDataSource.createAccount(
      name: name,
      type: type,
      startingBalance: startingBalance,
      isActive: isActive,
    );
  }

  /// Update an existing account
  Future<AccountCreateResponseModel> updateAccount({
    required int id,
    String? name,
    String? type,
    double? startingBalance,
    bool? isActive,
  }) async {
    return await _remoteDataSource.updateAccount(
      id: id,
      name: name,
      type: type,
      startingBalance: startingBalance,
      isActive: isActive,
    );
  }

  /// Delete an account
  Future<AccountDeleteResponseModel> deleteAccount(int id) async {
    return await _remoteDataSource.deleteAccount(id);
  }
}
