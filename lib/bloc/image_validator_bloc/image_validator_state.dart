part of 'image_validator_bloc.dart';

abstract class ImageValidatorState extends Equatable {
  const ImageValidatorState();

  @override
  List<Object> get props => [];
}

class ImageValidatorInitial extends ImageValidatorState {}

class ImageValidatorLoading extends ImageValidatorState {}

class ImageValidatorSuccess extends ImageValidatorState {
  final String imageUrl;

  const ImageValidatorSuccess({required this.imageUrl});

  @override
  List<Object> get props => [imageUrl];
}

class ImageValidatorFailure extends ImageValidatorState {
  final String message;

  const ImageValidatorFailure({required this.message});

  @override
  List<Object> get props => [message];
}
