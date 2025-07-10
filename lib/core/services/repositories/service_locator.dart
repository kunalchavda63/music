import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:music/core/services/navigation/router.dart';
import 'package:music/core/services/repositories/music_repository/music_repository.dart';
import 'package:music/core/utilities/src/helper_method.dart';
final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Make sure Flutter engine is initialized before using any services
  WidgetsFlutterBinding.ensureInitialized();
  await requestStoragePermission();

  // Register router or other services
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  getIt.registerLazySingleton<MusicRepository>(() => MusicRepository());

  // Optional: Unfocus any field on first frame (not usually needed unless restoring from a state)
  WidgetsBinding.instance.addPostFrameCallback((_) {
    FocusManager.instance.primaryFocus?.unfocus();
  });
}
