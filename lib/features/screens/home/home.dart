
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music/bloc/music_bloc/music_bloc.dart';
import 'package:music/core/app_ui/app_ui.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../bloc/music_bloc/music_state.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Size size;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF121212),
      appBar: CustomWidgets.customAppBar(
        bgColor: AppColors.hex1212,
        title: Row(
          children: [
            CustomWidgets.customText(
              data: 'Music',
              style: BaseStyle.s20w400.c(AppColors.hexF2c9)
            )
          ],
        )
      ),
      body: BlocBuilder<MusicBloc,MusicState>(
          builder: (context,state){
            if(state is MusicLoading){
              return const Center(child: CircularProgressIndicator(),);
            }
            else if(state is MusicLoaded){
              if(state.songs.isEmpty){
                return  Center(
                  child: CustomWidgets.customText(data: 'No Music files Found'),
                );
              }
              return ListView.builder(
                  itemCount: state.songs.length,
                  itemBuilder: (context,index){
                    final song = state.songs[index];
                    return  CustomWidgets.customAnimationWrapper(
                      curve: Curves.decelerate,
                        animationType: AnimationType.fadeScale,
                      duration: Duration(milliseconds: 800),
                      child: CustomWidgets.customContainer(
                        padding: EdgeInsets.only(right: 20),
                        h: 80.r,
                        w: size.width,
                        color: const Color(0xFF1F1B24), // 🔥 Card background
                        border: Border.all(color: const Color(0xFF424242), width: 2), // Subtle border
                        borderRadius: BorderRadius.circular(20.r),
                        child: Row(
                          children: [
                            CustomWidgets.customContainer(
                              h: 50.r,
                              w: 50.r,
                              border: Border.all(color: const Color(0xFF424242)),
                              boxShape: BoxShape.circle,
                              child: QueryArtworkWidget(
                                id: song.id,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: const Icon(Icons.music_note, color: Colors.white),
                              ),
                            ).padH(10.r),

                            /// Title & Duration
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Title
                                  CustomWidgets.customText(
                                    data: song.displayName,
                                    style: BaseStyle.s14w500.c(Colors.white),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  const SizedBox(height: 4),

                                  /// Duration
                                  CustomWidgets.customText(
                                    data: formatDuration(song.duration),
                                    style: BaseStyle.s14w500.c(Colors.grey[400]!),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ).padV(5).padH(5),
                    );
                  });
            }
            else if(state is MusicError){
              return Center(
                child: CustomWidgets.customText(data: 'Errror : ${state.message}'),
              );
            }
            return const SizedBox.shrink();
          })
    );
  }
  String formatDuration(int? milliseconds) {
    if (milliseconds == null) return "00:00:00";

    final duration = Duration(milliseconds: milliseconds);

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return "$hours:$minutes:$seconds";
  }


}
