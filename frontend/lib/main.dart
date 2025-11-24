import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constants/app_strings.dart';
import 'core/themes/app_themes.dart';
import 'core/navigation/navigation_service.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/account/account_bloc.dart';
import 'presentation/bloc/category/category_bloc.dart';
import 'presentation/bloc/transaction/transaction_bloc.dart';
import 'presentation/pages/splash/splash_page.dart';

void main() {
  runApp(const BookkeepingApp());
}

class BookkeepingApp extends StatelessWidget {
  const BookkeepingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<AccountBloc>(
          create: (context) => AccountBloc(),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => CategoryBloc(),
        ),
        BlocProvider<TransactionBloc>(
          create: (context) => TransactionBloc(),
        ),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
        home: const SplashPage(),
      ),
    );
  }
}
