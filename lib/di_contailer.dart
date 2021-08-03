import 'package:get_it/get_it.dart';
import 'package:madrasah_app/state_management/auth_state.dart';
import 'package:madrasah_app/state_management/file_attach_state.dart';
import 'package:madrasah_app/state_management/storage_state.dart';
import 'package:madrasah_app/utils/auth_repos/auth_repos.dart';
import 'package:madrasah_app/utils/fires_storage_repos.dart';
import 'package:madrasah_app/utils/firestore_repos/firestore_repos.dart';

final services = GetIt.I;

void init() {
  //Repos
  services.registerLazySingleton(() => AuthRepos());
  services.registerLazySingleton(() => FirestoreRepos());
  services.registerLazySingleton(() => StorageRepo());

  //Providers
  services.registerLazySingleton(() => AuthState(services()));
  services.registerLazySingleton(() => FileAttechState());
  services.registerLazySingleton(() => StorageState());
}
