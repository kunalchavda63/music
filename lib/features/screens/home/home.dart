
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music/bloc/music_bloc/music_bloc.dart';
import 'package:music/core/app_ui/app_ui.dart';
import 'package:music/core/services/navigation/router.dart';
import 'package:music/core/services/repositories/service_locator.dart';
import 'package:music/features/screens/home/play_music/play_music_screen.dart';
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
      backgroundColor: AppColors.black,
      appBar: CustomWidgets.customAppBar(
        bgColor: AppColors.hex1212,
        title: Row(
          children: [
            CustomWidgets.customText(
              data: 'Music',
              style: BaseStyle.s20w400.c(AppColors.persianPink)
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
                  child: CustomWidgets.customText(data: 'No Music files Found',style: BaseStyle.s14w500.c(AppColors.textSecondary)),
                );
              }
              return ListView.builder(
                  itemCount: state.songs.length,
                  itemBuilder: (context,index){
                    final song = state.songs[index];
                    return  CustomWidgets.customAnimationWrapper(
                      curve: Curves.decelerate,
                        animationType: AnimationType.slideFromBottom,
                      duration: Duration(milliseconds: 800),
                      child: CustomWidgets.customContainer(

                        padding: EdgeInsets.only(right: 20),
                        h: 80.r,
                        w: size.width,
                        borderRadius: BorderRadius.circular(20.r),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20.r),
                          splashColor: AppColors.eggBlue,
                          onTap: (){
                            getIt<AppRouter>().push(PlayMusicScreen(songModel: song,));
                          },
                          child: Row(
                            children: [
                              CustomWidgets.customContainer(
                                h: 50.r,
                                w: 50.r,
                                padding: EdgeInsets.all(10),
                                border: Border.all(color: AppColors.eggBlue),
                                boxShape: BoxShape.circle,
                                child: QueryArtworkWidget(
                                  id: song.id,
                                  type: ArtworkType.AUDIO,
                                  nullArtworkWidget: const Icon(Icons.music_note, color: AppColors.persianPink),
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
                        ),
                      ).padV(5).padH(5),
                    );
                  });
            }
            else if(state is MusicError){
              return Center(
                child: CustomWidgets.customText(data: 'Errror : ${state.message}',style: BaseStyle.s14w500.c(AppColors.hexF2c9)),
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
