import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/bloc/animation/animation_cubit.dart';
import 'package:music/bloc/animation/animation_rotate_cubit.dart';
import 'package:music/bloc/image_validator_bloc/image_validator_bloc.dart';
import 'package:music/bloc/music_bloc/music_bloc.dart';
import 'package:music/bloc/music_bloc/music_event.dart';
import 'package:music/bloc/nav_bloc/home_cubit.dart';
import 'package:music/core/services/navigation/router.dart';
import 'package:music/core/services/repositories/service_locator.dart';
import 'package:music/features/screens/screens.dart';


void main() async{
  await setupServiceLocator();


  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_)=>CurrentIndexCubit()),
          BlocProvider(create: (_)=>AnimationCubit()),
          BlocProvider(create: (_)=>AnimationRotateCubit()),
          BlocProvider(create: (_)=>ImageValidatorBloc()),
          BlocProvider(create: (_)=>MusicBloc()..add(FetchMusicEvent()))
        ],

          child: MyApp()));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375,812),
      builder: (context,child){
        return MaterialApp(
          navigatorKey: getIt<AppRouter>().navigatorKey,
          debugShowCheckedModeBanner: false,
          home: Screens(),
        );
      },
    );
  }
}
