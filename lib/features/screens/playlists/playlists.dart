import 'package:music/core/app_ui/app_ui.dart';
import 'package:music/core/services/navigation/router.dart';
import 'package:music/core/services/repositories/service_locator.dart';
import 'package:music/features/animation/simple_animation.dart';
import 'package:music/features/animation/triangle_border_image.dart';

class Playlists extends StatefulWidget {
  const Playlists({super.key});

  @override
  State<Playlists> createState() => _PlaylistsState();
}

class _PlaylistsState extends State<Playlists> {
  late Size size;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }
  @override
  Widget build(BuildContext context) {
    final g = getIt<AppRouter>();
    final List<AnimationScreeModel> animationScreenList = [
      AnimationScreeModel(icon: Icons.animation, label:'Simple Animation',onTap: ()=>g.push(SimpleAnimation())),
      AnimationScreeModel(icon: Icons.animation, label:'Rectangle Border Animation',onTap: ()=>g.push(TriangleBorderImage())),

    ];

    return Scaffold(
      appBar: CustomWidgets.customAppBar(
        bgColor: AppColors.whiteSmoke,
        title: CustomWidgets.customText(data: 'playlists',style: BaseStyle.s14w500.c(AppColors.redWine)),
        isCenterTitle: false,
        bottomOpacity: 0,
        elevation: 0,
        scrollUnderElevation: 0
      ),
      backgroundColor: AppColors.whiteSmoke,
      body:
          ListView.builder(
              itemCount: animationScreenList.length,
              itemBuilder: (context,index){
                final screen = animationScreenList[index];
                return CustomWidgets.customContainer(
                    onTap: screen.onTap,
                    h: 60.r,
                    w: size.width,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColors.redWine),
                    child: Row(
                      children: [
                        CustomWidgets.customCircleIcon(
                            h: 50.r,w: 50.r,
                            iconData: screen.icon,
                            iconColor: AppColors.redWine,
                            iconSize: 20
                        ),
                        CustomWidgets.customText(
                            data: screen.label,
                            style: BaseStyle.s14w500.c(AppColors.redWine)
                        )
                      ],
                    )
                ).padH(10.r).padV(10.r);

          })


    );
  }
}


class AnimationScreeModel {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  AnimationScreeModel({
    required this.icon,
    required this.label,
    required this.onTap
  });
}