import 'package:on_audio_query/on_audio_query.dart';

import '../../../../core/app_ui/app_ui.dart';

class PlayMusicScreen extends StatefulWidget {
  final SongModel songModel;
  const PlayMusicScreen({super.key, required this.songModel});

  @override
  State<PlayMusicScreen> createState() => _PlayMusicScreenState();
}

class _PlayMusicScreenState extends State<PlayMusicScreen>  with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomWidgets.customContainer(
            h: 60.r,
          ),
        ],
      ),
    );
  }
}
