import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/services/api_service.dart';
import 'package:frontend/data/services/auth_service.dart';
import 'package:frontend/data/datasources/auth_local_datasource.dart';
import 'package:frontend/presentation/bloc/auth/auth_event.dart';
import 'package:frontend/presentation/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  final ApiService _apiService;
  final AuthLocalDataSource _authLocalDataSource;

  AuthBloc({
    AuthService? authService,
    ApiService? apiService,
    AuthLocalDataSource? authLocalDataSource,
  }) : _authService = authService ?? AuthService(),
       _apiService = apiService ?? ApiService(),
       _authLocalDataSource = authLocalDataSource ?? AuthLocalDataSource(),
       super(const AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthCheckStatus>(_onCheckStatus);
    on<AuthGetCurrentUser>(_onGetCurrentUser);
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final response = await _authService.login(
        email: event.email,
        password: event.password,
      );

      // Token and user data already saved by auth_service.login()
      // Just emit authenticated state
      emit(AuthAuthenticated(user: response.user, token: response.token));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final response = await _authService.register(
        name: event.name,
        email: event.email,
        password: event.password,
        passwordConfirmation: event.passwordConfirmation,
      );

      emit(AuthRegistrationSuccess(message: response.message));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      await _authService.logout();
      emit(const AuthUnauthenticated());
    } catch (e) {
      // Even if logout fails, clear local auth state
      await _authLocalDataSource.clearAuthData();
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onCheckStatus(
    AuthCheckStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final isAuthenticated = await _authService.isAuthenticated();
    final token = await _authService.getAuthToken();
    final savedUser = await _authService.getSavedUserData();

    if (isAuthenticated && token != null && savedUser != null) {
      // User is authenticated with saved data
      emit(AuthAuthenticated(user: savedUser, token: token));
    } else {
      // Not authenticated or missing data
      await _authLocalDataSource.clearAuthData();
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onGetCurrentUser(
    AuthGetCurrentUser event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final response = await _authService.getCurrentUser();
      final token = await _apiService.getAuthToken();

      emit(AuthAuthenticated(user: response.user, token: token));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
