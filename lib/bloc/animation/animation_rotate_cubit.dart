import 'package:flutter_bloc/flutter_bloc.dart';

class AnimationRotateCubit extends Cubit<double> {
  AnimationRotateCubit() : super(0);
  void update(double value) => emit(value);
}