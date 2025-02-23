import 'package:assam_edu/core/routes/names.dart';
import 'package:assam_edu/core/storage_service/storage_service.dart';
import 'package:assam_edu/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:assam_edu/features/auth/presentation/pages/otp_screen.dart';
import 'package:assam_edu/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:assam_edu/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:assam_edu/features/educator/course_create/presentation/bloc/create_course_bloc.dart';
import 'package:assam_edu/features/educator/course_create/presentation/pages/course_create_page.dart';
import 'package:assam_edu/features/student/course_section/presentation/bloc/course_section_bloc.dart';
import 'package:assam_edu/features/student/presentation/pages/chapters_detail_screen.dart';
import 'package:assam_edu/features/student/course_detail/presentation/pages/course_detail_screen.dart';
import 'package:assam_edu/features/student/presentation/pages/course_purchased.dart';
import 'package:assam_edu/features/student/course_section/presentation/pages/video_play_screen.dart';
import 'package:assam_edu/features/educator/educator_home/presentation/pages/educator_home_screen.dart';
import 'package:assam_edu/features/home/presentation/pages/home_screen.dart';
import 'package:assam_edu/features/student/student_home/presentation/bloc/bloc/student_home_screen_bloc.dart';
import 'package:assam_edu/features/student/student_home/presentation/pages/student_home_screen.dart';
import 'package:assam_edu/features/start/presentation/pages/educator_screen.dart';
import 'package:assam_edu/features/start/presentation/pages/get_started_screen.dart';
import 'package:assam_edu/features/start/presentation/pages/splash_screen.dart';
import 'package:assam_edu/features/start/presentation/pages/student_screen.dart';
import 'package:assam_edu/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class PageEntity {
  String route;
  Widget page;
  dynamic bloc; //dynamic means it can be anything , null also.

  PageEntity({
    required this.route,
    required this.page,
    this.bloc,
  });
}

class AppPages {
  static List<PageEntity> route() {
    return [
      PageEntity(
        route: AppRoutes.INITIAL_ROUTE,
        page: const SplashScreen(),
      ),
      PageEntity(
        route: AppRoutes.GET_STARTED,
        page: const GetStartedScreen(),
      ),
      PageEntity(
        route: AppRoutes.LEARNER,
        page: const StudentScreen(),
      ),
      PageEntity(
        route: AppRoutes.EDUCATOR,
        page: const EducatorScreen(),
      ),
      PageEntity(
        route: AppRoutes.SIGN_UP,
        page: const SignUpScreen(),
        bloc: BlocProvider(create: (_) => getIt<AuthBloc>()),
      ),
      PageEntity(
        route: AppRoutes.SIGN_IN,
        page: const SignInScreen(),
        bloc: BlocProvider(create: (_) => getIt<AuthBloc>()),
      ),
      PageEntity(
        route: AppRoutes.OTP,
        page: const OtpScreen(),
        bloc: BlocProvider(
          create: (_) => getIt<AuthBloc>(),
        ),
      ),
      PageEntity(
        route: AppRoutes.HOME_PAGE,
        page: const HomeScreen(),
        //bloc: BlocProvider(create: (_) => getIt<HomePageBloc>()),
      ),
      PageEntity(
        route: AppRoutes.STU_HM_PAGE,
        page: const StudentHomeScreen(),
        bloc: BlocProvider(create: (_) => getIt<StudentHomeScreenBloc>()),
      ),
      PageEntity(
        route: AppRoutes.EDU_HM_PAGE,
        page: const EducatorHomeScreen(),
        // bloc: BlocProvider(create: (_) => getIt<HomePageBloc>()),
      ),
      PageEntity(
        route: AppRoutes.Course_Detail_Page,
        page: const CourseDetailScreen(),
      ),
      PageEntity(
        route: AppRoutes.Chapter_Detail_Page,
        page: const ChaptersScreen(),
      ),
      PageEntity(
        route: AppRoutes.Course_purchased_page,
        page: const CoursePurchased(),
      ),
      PageEntity(
        route: AppRoutes.Course_video_play,
        page: const VideoPlaySection(),
        bloc: BlocProvider(create: (_) => getIt<CourseSectionBloc>()),
      ),
      PageEntity(
        route: AppRoutes.Create_course,
        page: const CourseCreatePage(),
        bloc: BlocProvider(create: (_) => getIt<CreateCourseBloc>()),
      ),
    ];
  }

//storing all the blocs at one place..
  static List<BlocProvider> allBlocProviders(BuildContext context) {
    List<BlocProvider> blocProviders = <BlocProvider>[];
    for (var pageEntity in route()) {
      if (pageEntity.bloc != null) {
        blocProviders.add(pageEntity.bloc);
      }
    }
    return blocProviders;
  }

  static MaterialPageRoute generateRoute(RouteSettings settings) {
    if (settings.name != null) {
      var result = route().where((element) => settings.name == element.route);
      if (result.isNotEmpty) {
        print('Valid route name ${settings.name}'); // Debugging line
        try {
          final storageServices = GetIt.instance<StorageServices>();
          // print("StorageServices instance accessed"); // Debugging line

          bool deviceFirstOpen = storageServices.getDeviceFirstOpen();
          bool isLoggedIn = storageServices.getIsLoggedIn();
          print("Device first open  $deviceFirstOpen");
          print("User Logged in  $isLoggedIn");
          if (settings.name == AppRoutes.GET_STARTED &&
              deviceFirstOpen &&
              isLoggedIn) {
            return MaterialPageRoute(
              builder: (_) =>
                  const HomeScreen(), // Replace with actual home page
            );
          }
          print(result.first.page);
          return MaterialPageRoute(
            builder: (_) => result.first.page,
            settings: settings,
          );
        } catch (e) {
          print('Error accessing StorageServices: $e'); // Debugging line
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(
                child: Text(
                  'Initialization Error',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ),
          );
        }
      }
    }
    print('Invalid route name ${settings.name}'); // Debugging line
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text(
            'Page Does Not Exist',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
        ),
      ),
    );
  }
}
