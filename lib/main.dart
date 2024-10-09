import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/view/app.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'app/view/bloc_observer.dart';
import 'package:authentication_repository/authentication_repository.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  // HydratedBloc.storage = await HydratedStorage.build(
  //   storageDirectory: kIsWeb
  //       ? HydratedStorage.webStorageDirectory
  //       : await getApplicationDocumentsDirectory(),
  // );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  // runApp(MyApp());
  runApp(App(authenticationRepository: authenticationRepository));
}
