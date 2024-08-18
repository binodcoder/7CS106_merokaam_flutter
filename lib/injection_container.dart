import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'layers/data/job_profile/data_sources/job_profile_remote_data_sources.dart';
import 'layers/data/job_profile/repositories/job_profile_repository_impl.dart';
import 'layers/data/login/datasources/login_remote_data_source.dart';
import 'layers/data/login/repositories/login_repositories_impl.dart';
import 'layers/domain/job_profile/repositories/job_profile_repositories.dart';
import 'layers/domain/job_profile/usecases/create_job_profile.dart';
import 'layers/domain/job_profile/usecases/delete_job_profile.dart';
import 'layers/domain/job_profile/usecases/read_job_profile.dart';
import 'layers/domain/job_profile/usecases/update_job_profile.dart';
import 'layers/domain/login/repositories/login_repositories.dart';
import 'layers/domain/login/usecases/login.dart';
import 'layers/presentation/JobProfile/add_update_job_profile/bloc/create_job_profile_bloc.dart';
import 'layers/presentation/JobProfile/read_job_profile/bloc/read_job_profile_bloc.dart';
import 'layers/presentation/login/bloc/login_bloc.dart';
import 'package:http/http.dart' as http;

/*
It is a powerful dependency injection framework that enables registration and retrieval of dependencies,
improving testability and decoupling components, allowing easy access to services and models.
 */

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => ReadJobProfileBloc(
        getJobProfiles: sl(),
        updateJobProfile: sl(),
        deleteJobProfile: sl(),
      ));

  sl.registerFactory(() => CreateJobProfileBloc(
        createJobProfile: sl(),
        updateJobProfile: sl(),
        readJobProfile: sl(),
      ));

  sl.registerLazySingleton(() => CreateJobProfile(sl()));
  sl.registerLazySingleton(() => ReadJobProfile(sl()));
  sl.registerLazySingleton(() => DeleteJobProfile(sl()));
  sl.registerLazySingleton(() => UpdateJobProfile(sl()));

  sl.registerLazySingleton<JobProfileRepository>(
    () => JobProfileRepositoryImpl(
      jobProfileRemoteDataSources: sl(),
    ),
  );
  sl.registerLazySingleton<JobProfileRemoteDataSource>(() => JobProfileRemoteDataSourceImpl(
        client: sl(),
      ));

  //login
  sl.registerFactory(() => LoginBloc(login: sl()));

  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<LoginRemoteDataSource>(() => LoginRemoteDataSourceImpl(client: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
