import 'package:get_it/get_it.dart';
import 'package:whatcolors/app/features/color_picker/presentation/state/home_screen_viewmodel.dart';

final sl = GetIt.instance;

void serviceLocator() {
  sl.registerLazySingleton<IHomeScreenViewmodel>(() => HomeScreenViewmodel());
}
