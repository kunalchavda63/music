import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// AnimationCubit manages the current animated state, which includes a value and a color.
class AnimationCubit extends Cubit<AnimatedState> {
  AnimationCubit()
      : super(
    AnimatedState(value: 0.0, color: Colors.blue),
  );

  void updateValue(double value) {
    emit(state.copyWith(value: value));
  }

  void updateColor(Color color) {
    emit(state.copyWith(color: color));
  }

  void reset() {
    emit(const AnimatedState(value: 0.0, color: Colors.blue));
  }
}


class AnimatedState {
  final double value;
  final Color color;

  const AnimatedState({
    required this.value,
    required this.color,
  });

  AnimatedState copyWith({
    double? value,
    Color? color,
  }) {
    return AnimatedState(
      value: value ?? this.value,
      color: color ?? this.color,
    );
  }
}
