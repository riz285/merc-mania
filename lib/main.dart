import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:merc_mania/consts.dart';
import 'package:path_provider/path_provider.dart';
import 'app/view/app.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';

import 'app/view/bloc_observer.dart';
import 'package:authentication_repository/authentication_repository.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  Bloc.observer = const AppBlocObserver();

  /// initialize hydrated bloc
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  // runApp(MyApp());
  runApp(App(authenticationRepository: authenticationRepository));
}
