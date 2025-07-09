import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'music_event.dart';
import 'music_state.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  final OnAudioQuery audioQuery = OnAudioQuery();


  MusicBloc() : super(MusicInitial()) {
    on<FetchMusicEvent>(_onFetchMusic);
  }

  Future<void> _onFetchMusic(FetchMusicEvent event, Emitter<MusicState> emit) async {
    emit(MusicLoading());

    try {
      // Ask for permission
      var status = await Permission.audio.status;
      if (!status.isGranted) {
        status = await Permission.audio.request();
        if (!status.isGranted) {
          emit(MusicError("Permission denied"));
          return;
        }
      }

      // Query songs
      final songs = await audioQuery.querySongs(
        uriType: UriType.EXTERNAL,
        sortType: SongSortType.DISPLAY_NAME,
        orderType: OrderType.ASC_OR_SMALLER,
        ignoreCase: true,
      );

      emit(MusicLoaded(songs));
    } catch (e) {
      emit(MusicError(e.toString()));
    }
  }
}
