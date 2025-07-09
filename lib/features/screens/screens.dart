import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music/core/app_ui/app_ui.dart';
import 'package:music/core/utilities/utils.dart';
import 'package:music/features/screens/home/home.dart';
import 'package:music/bloc/nav_bloc/home_cubit.dart';
import 'package:music/features/screens/playlists/playlists.dart';

class Screens extends StatelessWidget {
  const Screens({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [Home(),Playlists()];
    return Scaffold(
      body: BlocBuilder<CurrentIndexCubit,int>(
          builder: (context,state){
      return screens[state];
          }
      ),
      bottomNavigationBar: BlocBuilder<CurrentIndexCubit,int>(
        builder: (context,state){
          return CustomWidgets.customBottomNavigationBar(
              currentIndex: state,
              bottomNavList: bottomList,
              onTap: (val){
                context.read<CurrentIndexCubit>().change(val);
                logger.i(val);
              }
          );
        }
      ),
    );
  }
}

List<BottomNavModel> bottomList = <BottomNavModel>[
BottomNavModel(icon: Icons.home, label:'Home'),
BottomNavModel(icon: Icons.playlist_add_check_outlined, label:'PlayLists')
];
