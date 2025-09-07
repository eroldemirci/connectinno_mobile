import 'package:connectinno_case/ui/pages/note_details_page/viewmodel/note_details_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:connectinno_case/core/services/note_services.dart';
import 'package:connectinno_case/ui/pages/main_page/pages/home_page/viewmodel/home_cubit.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<NoteServices>(() => NoteServices());
  getIt.registerSingleton<HomeCubit>(HomeCubit(getIt<NoteServices>()));
  getIt.registerFactory<NoteDetailsCubit>(() => NoteDetailsCubit());
}
