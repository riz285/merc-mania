import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/home/cubit/recently_viewed_cubit.dart';
import 'package:merc_mania/screens/cart/cubit/cart_cubit.dart';
import 'package:merc_mania/screens/profile/cubit/profile_cubit.dart';

import '../../core/configs/themes/app_themes.dart';
import '../../screens/theme_modes/cubit/theme_cubit.dart';
import '../bloc/app_bloc.dart';
import '../routes/routes.dart';

class App extends StatelessWidget {
  const App({
    required AuthenticationRepository authenticationRepository,
    super.key,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()), // App Theme
          BlocProvider<AppBloc>( // User Auth Bloc
            lazy: false,
              create: (_) => AppBloc(
                authenticationRepository: _authenticationRepository,
              )..add(const AppUserSubscriptionRequested())
            ), 
          BlocProvider<RecentlyViewedCubit>(create: (_) => RecentlyViewedCubit(_authenticationRepository)), // User's history
          BlocProvider<CartCubit>(create: (_) => CartCubit(_authenticationRepository)), // Shopping Cart
          BlocProvider<ProfileCubit>(create: (_) => ProfileCubit(_authenticationRepository)), // Profile display
          // Address
        ],
        child: const AppView(),
      )
    );
  }
}

/// This widget is the root of your application.
class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(builder: (context, mode) => 
      MaterialApp(
        // Initialize app's ThemeData
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        // Theme based on user's system
        themeMode: mode,
        
        debugShowCheckedModeBanner: false, 
        // home: HomePage(),
        home: FlowBuilder<AppStatus>(
          state: context.select((AppBloc bloc) => bloc.state.status),
          onGeneratePages: onGenerateAppViewPages,
        ),
      )
    );
  }
}