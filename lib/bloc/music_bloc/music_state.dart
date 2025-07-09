import 'package:on_audio_query/on_audio_query.dart';

abstract class MusicState {}

class MusicInitial extends MusicState {}

class MusicLoading extends MusicState {}

class MusicLoaded extends MusicState {
  final List<SongModel> songs;

  MusicLoaded(this.songs);
}

class MusicError extends MusicState {
  final String message;

  MusicError(this.message);
}
