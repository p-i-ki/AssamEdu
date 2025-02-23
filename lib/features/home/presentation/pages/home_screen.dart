import 'package:assam_edu/core/storage_service/storage_service.dart';
import 'package:assam_edu/features/educator/educator_home/presentation/pages/educator_home_screen.dart';
import 'package:assam_edu/features/student/student_home/presentation/pages/student_home_screen.dart';
import 'package:assam_edu/init_dependencies.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final storageServices = getIt<StorageServices>();
    final String userType = storageServices.getUserType();
    return userType == "instructor"
        ? const EducatorHomeScreen()
        : const StudentHomeScreen();
  }
}
