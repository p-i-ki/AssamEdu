import 'package:assam_edu/core/app_constants/app_constants.dart';
import 'package:assam_edu/core/storage_service/storage_service.dart';
import 'package:assam_edu/core/utlis/http_util.dart';
import 'package:assam_edu/features/auth/data/data_resources/auth_remote_data_source.dart';
import 'package:assam_edu/features/auth/data/repository/auth_repository_impl.dart';
import 'package:assam_edu/features/auth/domain/repository/auth_repository.dart';
import 'package:assam_edu/features/auth/domain/use_cases/user_sign_in.dart';
import 'package:assam_edu/features/auth/domain/use_cases/user_sign_up.dart';
import 'package:assam_edu/features/auth/domain/use_cases/user_verify_otp.dart';
import 'package:assam_edu/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:assam_edu/features/course/course_create/presentation/bloc/create_course_bloc.dart';
import 'package:assam_edu/features/student/data/data_resources/get_course_remote_data_source.dart';
import 'package:assam_edu/features/student/data/repository/get_course_repository_impl.dart';
import 'package:assam_edu/features/student/domain/repository/get_course_repository.dart';
import 'package:assam_edu/features/student/domain/use_cases/get_all_courses.dart';
import 'package:assam_edu/features/student/domain/use_cases/get_course_videos.dart';
import 'package:assam_edu/features/student/presentation/bloc/home_page_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

class Global {
  static Future<void> init() async {
    _initAuth();
    // Initialize and register StorageServices with Get It
    final storageServices = await StorageServices().init();
    getIt.registerSingleton<StorageServices>(storageServices);
    // Register Dio with base options
    getIt.registerSingleton<Dio>(Dio(BaseOptions(
      baseUrl: AppConstants.SERVER_API_URL,
      connectTimeout: const Duration(seconds: 200),
      receiveTimeout: const Duration(seconds: 200),
      headers: {},
      contentType: "application/json; charset=utf-8",
      responseType: ResponseType.json,
    )));
    // Register HttpUtil with the injected Dio instance
    getIt.registerLazySingleton<HttpUtil>(() => HttpUtil(dio: getIt<Dio>()));
    _initStudentHomePage();
    _initCreateCourse();
  }
}

void _initAuth() {
  getIt
    // Data Source
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(httpUtil: getIt<HttpUtil>()))
    // Repository
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()))
    // Use cases
    ..registerFactory(() => UserSignUp(getIt<AuthRepository>()))
    ..registerFactory(() => UserSignIn(getIt<AuthRepository>()))
    ..registerFactory(() => UserVerifyOtp(getIt<AuthRepository>()))
    // Bloc
    ..registerLazySingleton(() => AuthBloc(
          userSignUp: getIt<UserSignUp>(),
          userSignIn: getIt<UserSignIn>(),
          userVerifyOtp: getIt<UserVerifyOtp>(),
        ));
}

void _initStudentHomePage() {
  getIt
    // Data Source
    ..registerFactory<GetCourseRemoteDataSource>(
        () => GetCourseRemoteDataSourceImpl(httpUtil: getIt<HttpUtil>()))
    // Repository
    ..registerFactory<GetCourseRepository>(() => GetCourseRepositoryImpl(
        getCourseRemoteDataSouce: getIt<GetCourseRemoteDataSource>()))
    // UseCases
    ..registerFactory(() => GetAllCourses(getIt<GetCourseRepository>()))
    ..registerFactory(() => GetCourseVideos(getIt<GetCourseRepository>()))
    // Bloc
    ..registerLazySingleton(() => HomePageBloc(
          getAllCourses: getIt<GetAllCourses>(),
          getCourseVideos: getIt<GetCourseVideos>(),
        ));
}

void _initCreateCourse() {
  getIt.registerLazySingleton(() => CreateCourseBloc());
}
