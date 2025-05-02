import 'package:assam_edu/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:assam_edu/core/config/db_config.dart';

import '../../../../../core/routes/names.dart';

class LocalCoursesTab extends StatefulWidget {
  const LocalCoursesTab({
    super.key,
  });
  @override
  State<LocalCoursesTab> createState() => _LocalCoursesTabState();
}

class _LocalCoursesTabState extends State<LocalCoursesTab> {
  late Future<List<Map<String, dynamic>>> _localCoursesFuture;
  final db = getIt<DBHelper>();

  @override
  void initState() {
    super.initState();
    _localCoursesFuture = db.getCourses();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("---Inside Build method of Local Course Tab---");
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _localCoursesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text('No courses available in local database.'));
        } else {
          return CoursesList(courses: snapshot.data!);
        }
      },
    );
  }
}

// Widget to display list of courses
class CoursesList extends StatelessWidget {
  final List<Map<String, dynamic>> courses;

  const CoursesList({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return CourseCard(courseData: course);
      },
    );
  }
}

class CourseCard extends StatelessWidget {
  final Map<String, dynamic> courseData;

  const CourseCard({super.key, required this.courseData});

  @override
  Widget build(BuildContext context) {
    // Convert BLOB data to Uint8List
    Uint8List? imageBytes = courseData[DBHelper.COLUMN_THUMBNAIL];

    return GestureDetector(
      onTap: () {
        // Navigate to Course Detail Page
        Navigator.pushNamed(context, AppRoutes.EDU_COURSE_DETAIL, arguments: {
          "courseId": courseData[DBHelper.COLUMN_ID],
          "title": courseData[DBHelper.COLUMN_TITLE],
          "price": courseData[DBHelper.COLUMN_PRICE],
          "desc": courseData[DBHelper.COLUMN_DESC],
          "thumbnailUrl": courseData[DBHelper.COLUMN_THUMBNAIL],
          "createdAt": courseData[DBHelper.COLUMN_DATE] == null
              ? "NA"
              : courseData[DBHelper.COLUMN_DATE]
                  .toIso8601String()
                  .substring(0, 10)
        });
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the image using Image.memory
              if (imageBytes != null)
                Image.memory(
                  imageBytes,
                  height: 100, // Adjust as needed
                  width: double.infinity,
                  fit: BoxFit.cover, // Or any other fit you prefer
                )
              else if (courseData['imageUrl'] != null) //for remote image
                Image.network(
                  courseData['imageUrl'],
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              else
                //show a placeholder
                Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.grey,
                  child: const Center(child: Text('No Image')),
                ),
              Text('Title: ${courseData[DBHelper.COLUMN_TITLE]}'),
              Text('Description: ${courseData[DBHelper.COLUMN_DESC]}'),
              Text('Price: ${courseData[DBHelper.COLUMN_PRICE]}'),
              Text('Date: ${courseData[DBHelper.COLUMN_DATE]}'),
            ],
          ),
        ),
      ),
    );
  }
}
