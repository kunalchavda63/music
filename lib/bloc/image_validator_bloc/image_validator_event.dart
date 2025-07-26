part of  'image_validator_bloc.dart';

abstract class ImageValidatorEvent extends Equatable{
  const ImageValidatorEvent();

  @override
  List<Object> get props => [];

}

class ValidatorImageEvent extends ImageValidatorEvent{
  final String url;
  const ValidatorImageEvent(this.url);

  @override
  List<Object> get props => [];
}

