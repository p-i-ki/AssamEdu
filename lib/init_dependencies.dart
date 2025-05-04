import 'package:assam_edu/core/app_constants/app_constants.dart';
import 'package:assam_edu/core/config/db_config.dart';
import 'package:assam_edu/core/storage_service/storage_service.dart';
import 'package:assam_edu/core/api/http_util.dart';
import 'package:assam_edu/features/auth/data/data_resources/auth_remote_data_source.dart';
import 'package:assam_edu/features/auth/data/repository/auth_repository_impl.dart';
import 'package:assam_edu/features/auth/domain/repository/auth_repository.dart';
import 'package:assam_edu/features/auth/domain/use_cases/user_sign_in.dart';
import 'package:assam_edu/features/auth/domain/use_cases/user_sign_up.dart';
import 'package:assam_edu/features/auth/domain/use_cases/user_verify_otp.dart';
import 'package:assam_edu/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:assam_edu/features/educator/add_sections/data/data%20source/add_section_remote_data_source.dart';
import 'package:assam_edu/features/educator/add_sections/data/repository/add_section_repository_impl.dart';
import 'package:assam_edu/features/educator/add_sections/domain/repository/add_section_repository.dart';
import 'package:assam_edu/features/educator/add_sections/domain/use%20cases/add_section_name.dart';
import 'package:assam_edu/features/educator/add_sections/domain/use%20cases/add_section_video.dart';
import 'package:assam_edu/features/educator/add_sections/presentation/bloc/add_section_bloc.dart';
import 'package:assam_edu/features/educator/course_create/data/data_resources/create_course_remote_data_source.dart';
import 'package:assam_edu/features/educator/course_create/data/repository/create_course_repositoy_impl.dart';
import 'package:assam_edu/features/educator/course_create/domain/repository/create_course_repository.dart';
import 'package:assam_edu/features/educator/course_create/domain/use_cases/create_course.dart';
import 'package:assam_edu/features/educator/course_create/presentation/bloc/create_course_bloc.dart';
import 'package:assam_edu/features/educator/course_detail/data/repository/get_section_repository_impl.dart';
import 'package:assam_edu/features/educator/course_detail/domain/repository/get_sections_repository.dart';
import 'package:assam_edu/features/educator/course_detail/domain/use_cases/get_sections.dart';
import 'package:assam_edu/features/educator/course_detail/presentation/bloc/educator_course_detail_screen_bloc.dart';
import 'package:assam_edu/features/educator/educator_home/data/data_resource/get_instructor_course_remote_data_source.dart';
import 'package:assam_edu/features/educator/educator_home/data/repository/get_instructor_course_repository_impl.dart';
import 'package:assam_edu/features/educator/educator_home/domain/repository/get_instructor_course_repository.dart';
import 'package:assam_edu/features/educator/educator_home/domain/use_cases/get_instructor_courses.dart';
import 'package:assam_edu/features/educator/educator_home/presentation/bloc/educator_home_screen_bloc.dart';
import 'package:assam_edu/features/educator/profile/data/data_source/educator_profile_remote_data_source.dart';
import 'package:assam_edu/features/educator/profile/data/repository/create_educator_profile_repo_impl.dart';
import 'package:assam_edu/features/educator/profile/domain/repositories/create_educator_profile_repository.dart';
import 'package:assam_edu/features/educator/profile/domain/use_cases/create_educator_profile.dart';
import 'package:assam_edu/features/educator/profile/presentation/bloc/eudcator_profile_bloc.dart';
import 'package:assam_edu/features/student/course_section/data/data_resources/course_section_remote_data_sources.dart';
import 'package:assam_edu/features/student/course_section/data/repository/course_section_repository_impl.dart';
import 'package:assam_edu/features/student/course_section/domain/repository/course_section_repository.dart';
import 'package:assam_edu/features/student/course_section/domain/use_cases/get_course_videos.dart';
import 'package:assam_edu/features/student/course_section/presentation/bloc/course_section_bloc.dart';
import 'package:assam_edu/features/student/student_home/data/data_resources/get_course_remote_data_source.dart';
import 'package:assam_edu/features/student/student_home/data/repository/get_course_repository_impl.dart';
import 'package:assam_edu/features/student/student_home/domain/repository/get_course_repository.dart';
import 'package:assam_edu/features/student/student_home/domain/use_cases/get_all_courses.dart';
import 'package:assam_edu/features/student/student_home/presentation/bloc/bloc/student_home_screen_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'features/educator/course_detail/data/data_resources/get_sections_remote_data_source.dart';

final GetIt getIt = GetIt.instance;

class Global {
  static Future<void> init() async {
    _initAuth();
    _initDB();
    // Initialize and register StorageServices with Get It
    final storageServices = await StorageServices().init();
    getIt.registerSingleton<StorageServices>(storageServices);

    // Register Dio with base options
    getIt.registerSingleton<Dio>(Dio(BaseOptions(
      baseUrl: AppConstants.SERVER_API_URL,
      connectTimeout: const Duration(seconds: 100),
      receiveTimeout: const Duration(seconds: 100),
      headers: {},
      contentType: "application/json; charset=utf-8",
      responseType: ResponseType.json,
    )));
    // Register HttpUtil with the injected Dio instance
    getIt.registerLazySingleton<HttpUtil>(() => HttpUtil(dio: getIt<Dio>()));
    // For memory optimization we need to add only one initialization , either for student or instructor..
    _initStudentHomePage();
    _initStudentCourseSection();
    _initCreateCourse();
    _initAddSectionName();
    _initEducatorHome();
    _initEducatorGetSections();
    _initEducatorProfile();
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

void _initDB() {
  final db = DBHelper();
  getIt.registerLazySingleton<DBHelper>(() => db);
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
    // Bloc
    ..registerLazySingleton(() => StudentHomeScreenBloc(
          getAllCourses: getIt<GetAllCourses>(),
        ));
}

void _initStudentCourseSection() {
  getIt
    ..registerFactory<CourseSectionRemoteDataSource>(
        () => CourseSectionRemoteDataSourceImpl(httpUtil: getIt<HttpUtil>()))
    ..registerFactory<CourseSectionRepository>(() =>
        CourseSectionRepositoryImpl(
            getCourseRemoteDataSouce: getIt<CourseSectionRemoteDataSource>()))
    ..registerFactory(() => GetCourseVideos(
        courseSectionRepository: getIt<CourseSectionRepository>()))
    ..registerLazySingleton(
        () => CourseSectionBloc(getCourseVideos: getIt<GetCourseVideos>()));
}

void _initCreateCourse() {
  getIt
    ..registerFactory<CreateCourseRemoteDataSource>(
        () => CreateCourseRemoteDataSourceImpl(httpUtil: getIt<HttpUtil>()))
    ..registerFactory<CreateCourseRepository>(() => CreateCourseRepositoyImpl(
        courseRemoteDataSource: getIt<CreateCourseRemoteDataSource>()))
    ..registerFactory(() => CreateCourse(getIt<CreateCourseRepository>()))
    ..registerLazySingleton(
        () => CreateCourseBloc(createCourse: getIt<CreateCourse>()));
}

void _initAddSectionName() {
  getIt
    ..registerFactory<AddSectionRemoteDataSource>(
        () => AddSectionRemoteDataSourceImpl(httpUtil: getIt<HttpUtil>()))
    ..registerFactory<AddSectionRepository>(() => AddSectionRepositoryImpl(
        addSectionRemoteDataSource: getIt<AddSectionRemoteDataSource>()))
    ..registerFactory(() => AddSectionName(getIt<AddSectionRepository>()))
    ..registerFactory(() => AddSectionVideo(getIt<AddSectionRepository>()))
    ..registerLazySingleton(() => AddSectionBloc(
        addSectionName: getIt<AddSectionName>(),
        addSectionVideo: getIt<AddSectionVideo>()));
}

void _initEducatorHome() {
  getIt
    ..registerFactory<GetInstructorCourseRemoteDataSource>(() =>
        GetInstructorCourseRemoteDataSourceImpl(httpUtil: getIt<HttpUtil>()))
    ..registerFactory<GetInstructorCourseRepository>(() =>
        GetInstructorCourseRepositoryImpl(
            getIt<GetInstructorCourseRemoteDataSource>()))
    ..registerFactory(() => GetInstructorCourses(
        getInstructorCourseRepository: getIt<GetInstructorCourseRepository>()))
    ..registerLazySingleton(() => EducatorHomeScreenBloc(
          getInstructor: getIt<GetInstructorCourses>(),
        ));
}

void _initEducatorGetSections() {
  getIt
    ..registerFactory<GetSectionsRemoteDataSource>(
        () => GetSectionsRemoteDataSourceImpl(httpUtil: getIt<HttpUtil>()))
    ..registerFactory<GetSectionsRepository>(() => GetSectionRepositoryImpl(
        getSectionsRemoteDataSource: getIt<GetSectionsRemoteDataSource>()))
    ..registerFactory(() =>
        GetSections(getSectionsRepository: getIt<GetSectionsRepository>()))
    ..registerLazySingleton(() => EducatorCourseDetailScreenBloc(
          getSections: getIt<GetSections>(),
        ));
}

void _initEducatorProfile() {
  getIt
    ..registerFactory<EducatorProfileRemoteDataSource>(
        () => EducatorProfileRemoteDataSourceImpl(httpUtil: getIt<HttpUtil>()))
    ..registerFactory<CreateEducatorProfileRepository>(() =>
        CreateEducatorProfileRepoImpl(
            educatorProfileRemoteDataSource:
                getIt<EducatorProfileRemoteDataSource>()))
    ..registerFactory(() => CreateEducatorProfile(
        createEducatorProfileRepository:
            getIt<CreateEducatorProfileRepository>()))
    ..registerLazySingleton(() => EudcatorProfileBloc(
        createEducatorPrifle: getIt<CreateEducatorProfile>()));
}
