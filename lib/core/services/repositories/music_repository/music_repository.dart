import 'package:music/core/services/repositories/base_repo/base_repo.dart';
import 'package:music/core/utilities/src/helper_method.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicRepository extends BaseRepo{
   OnAudioQuery  get  audioQuery => OnAudioQuery();

  Future<List<SongModel>> fetchSongs() async{
    await requestStoragePermission();
    List<SongModel> songs = await audioQuery.querySongs(
      sortType: SongSortType.DISPLAY_NAME,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true
    );
    return songs;
  }

}