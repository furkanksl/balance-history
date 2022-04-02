import 'package:balance_history/data/repositories/history_repository_impl.dart';
import 'package:balance_history/data/services/api/api_service.dart';
import 'package:balance_history/domain/repositories/history_repository.dart';
import 'package:balance_history/domain/usecases/get_all_history.dart';
import 'package:balance_history/presentation/bloc/history_bloc/history_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => HistoryBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => GetAllHistory(locator()));

  // repository
  locator.registerLazySingleton<HistoryRepository>(
    () => HistoryRepositoryImpl(
      apiService: locator(),
    ),
  );

  // data source
  locator.registerLazySingleton<ApiService>(
    () => ApiServiceImpl(),
  );
}
