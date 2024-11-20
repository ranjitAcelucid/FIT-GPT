import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sales/core/network/api_service.dart';
import 'package:sales/core/network/dio_factory.dart';
import 'package:sales/core/network/network_info.dart';
import 'package:sales/cubit/auth/auth_cubit.dart';
import 'package:sales/repositories/auth/auth_repo.dart';
import 'package:sales/utils/services/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => prefs);
  getIt.registerLazySingleton<MySharedPref>(() => MySharedPref(getIt()));

  getIt.registerLazySingleton<DioFactory>(() => DioFactory());
  final dio = await getIt<DioFactory>().getDio();

  getIt.registerLazySingleton(() => ApiService(
        dio,
        getIt(),
      ));
  //Dio
  // getIt.registerLazySingleton<Dio>(() => Dio());
  // getIt.registerLazySingleton<DioClient>(() => DioClient(getIt<Dio>()));

  getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  //  repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
        apiServcie: getIt(), networkInfo: getIt(), mySharedPref: getIt()),
  );

  // Bloc
  getIt.registerFactory(
      () => AuthCubit(authRepository: getIt<AuthRepository>()));
}
