
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;

class CurrentIndexCubit extends Cubit<int>{
  CurrentIndexCubit() :super(0);

  void change(index){
    emit(index);
  }

}