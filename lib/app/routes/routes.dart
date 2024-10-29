import 'package:flutter/widgets.dart';

import '../../auth/login/view/login_page.dart';
import '../../home/view/home_view.dart';
import '../bloc/app_bloc.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomeView.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}