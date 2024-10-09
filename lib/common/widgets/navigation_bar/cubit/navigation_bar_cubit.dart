import 'package:flutter_bloc/flutter_bloc.dart';

class StyledNavigationBarCubit extends Cubit<int> {
  StyledNavigationBarCubit() : super(0);

  void navigateToPage(int index) {
    emit(index);
  }
}