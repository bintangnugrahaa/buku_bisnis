import 'package:frontend/data/datasources/auth_remote_datasource.dart';
import 'package:frontend/data/datasources/auth_local_datasource.dart';
import 'package:frontend/data/models/response/auth_response_model.dart';

class AuthService {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthService({
    AuthRemoteDataSource? remoteDataSource,
    AuthLocalDataSource? localDataSource,
  }) : _remoteDataSource = remoteDataSource ?? AuthRemoteDataSource(),
       _localDataSource = localDataSource ?? AuthLocalDataSource();

  /// Register a new user
  Future<RegisterResponseModel> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    return await _remoteDataSource.register(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }

  /// Login user and get auth token
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _remoteDataSource.login(
      email: email,
      password: password,
    );

    // Save auth token and user data to local storage
    await _localDataSource.saveAuthToken(response.token);
    await _localDataSource.saveUserData(response.user);

    return response;
  }

  /// Get current authenticated user
  Future<GetCurrentUserResponseModel> getCurrentUser() async {
    final response = await _remoteDataSource.getCurrentUser();

    // Save user data to local storage
    await _localDataSource.saveUserData(response.user);

    return response;
  }

  /// Get authenticated user (alternative endpoint)
  Future<UserModel> getAuthenticatedUser() async {
    final user = await _remoteDataSource.getAuthenticatedUser();

    // Save user data to local storage
    await _localDataSource.saveUserData(user);

    return user;
  }

  /// Logout user and revoke all tokens
  Future<LogoutResponseModel> logout() async {
    final response = await _remoteDataSource.logout();

    // Clear local auth data
    await _localDataSource.clearAuthData();

    return response;
  }

  /// Check if user is authenticated
  Future<bool> isAuthenticated() async {
    return await _localDataSource.isLoggedIn();
  }

  /// Get saved auth token
  Future<String?> getAuthToken() async {
    return await _localDataSource.getAuthToken();
  }

  /// Get saved user data
  Future<UserModel?> getSavedUserData() async {
    return await _localDataSource.getUserData();
  }
}
