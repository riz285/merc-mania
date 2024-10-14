import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  
  ThemeCubit() : super(ThemeMode.system);

  void toggleTheme() {
    emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  void  setTheme(ThemeMode themeMode) => emit(themeMode);

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    return ThemeMode.values[json['theme'] as int];
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
     return {'theme': state.index};
  }
  

}