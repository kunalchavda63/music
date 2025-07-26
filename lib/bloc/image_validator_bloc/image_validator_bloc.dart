import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';

part 'image_validator_event.dart';
part 'image_validator_state.dart';


class ImageValidatorBloc extends Bloc<ImageValidatorEvent,ImageValidatorState>{
  ImageValidatorBloc(): super(ImageValidatorInitial()){
    on<ValidatorImageEvent>(_onValidateImageUrl);
  }

  Future<void> _onValidateImageUrl (
      ValidatorImageEvent event,
      Emitter<ImageValidatorState> emit,

      ) async{
    emit(ImageValidatorLoading());
    try{
      final response = await http.head(Uri.parse(event.url));
      final contentType = response.headers['content-type'];
    if(response.statusCode == 200 && contentType != null){
      emit(ImageValidatorSuccess(imageUrl: event.url));
    } else{
      emit(ImageValidatorFailure(message: 'Not a valid Image Url'));
    }
    }
    catch (e){
      emit(ImageValidatorFailure(message: 'Invalid or unreachable URL'));
    }
  }
}
