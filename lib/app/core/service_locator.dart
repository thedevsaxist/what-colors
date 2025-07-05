import 'package:get_it/get_it.dart';
import 'package:whatcolors/app/core/theme/theme.dart';
import 'package:whatcolors/app/features/color_picker/data/services/color_extractor_service.dart';
import 'package:whatcolors/app/features/color_picker/presentation/state/home_screen_viewmodel.dart';

final sl = GetIt.instance;

void serviceLocator() {
  sl.registerLazySingleton<IColorExtractorService>(
    () => ColorExtractorService(),
  );
  sl.registerLazySingleton<IHomeScreenViewmodel>(
    () => HomeScreenViewmodel(
      colorExtractorService: sl<IColorExtractorService>(),
    ),
  );

  sl.registerLazySingleton<AppTheme>(() => AppTheme());
}
