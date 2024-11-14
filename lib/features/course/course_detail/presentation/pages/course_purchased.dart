import 'package:assam_edu/core/routes/names.dart';
import 'package:assam_edu/core/utlis/percentage_bar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CoursePurchased extends StatefulWidget {
  // static const String routeName = '/purchased-courses';

  const CoursePurchased({super.key});

  @override
  State<CoursePurchased> createState() => _CoursePurchasedState();
}

class _CoursePurchasedState extends State<CoursePurchased> {
  final List<Course> courses = [
    Course(
      title: 'React Course',
      completedChapters: 21,
      totalChapters: 43,
      icon: Icons.code,
      tasks: [
        Task(day: 20, title: 'Build a project'),
        Task(day: 21, title: 'Build a project'),
        Task(day: 22, title: 'Build a project'),
      ],
    ),
    Course(
      title: 'JavaScript Course',
      completedChapters: 17,
      totalChapters: 34,
      icon: Icons.computer,
      tasks: [
        Task(day: 20, title: 'Build a project'),
        Task(day: 21, title: 'Build a project'),
        Task(day: 22, title: 'Build a project'),
      ],
    ),
    Course(
      title: 'Python Course',
      completedChapters: 20,
      totalChapters: 40,
      icon: Icons.laptop,
      tasks: [
        Task(day: 20, title: 'Build a project'),
        Task(day: 21, title: 'Build a project'),
        Task(day: 22, title: 'Build a project'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('FFFFFF'),
      appBar: AppBar(
        title: Text(
          'Your Courses',
          style: TextStyle(
            color: HexColor('33312E'),
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: InkWell(
            onTap: () {},
            child: Icon(
              Icons.arrow_back_ios,
              color: HexColor('33312E'),
              size: 20,
            )),
        backgroundColor: HexColor('FFFFFF'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 270,
              child: CourseCard(course: course));
        },
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(top: 4, bottom: 12, left: 6, right: 6),
        elevation: 6.0,
        color: HexColor('DFF8FF'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 4.0, left: 6, right: 4, bottom: 6),
          child: Row(
            children: [
              //1st column
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Expanded(
                  child: Column(
                    children: [
                      Container(
                        // margin: EdgeInsets.only(top: 5),
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            image: const DecorationImage(
                                image: AssetImage(
                                  'assets/pyhton.jpg',
                                ),
                                fit: BoxFit.fill)),
                      ),
                      Text(
                        course.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 22,
                          color: HexColor('134C5D'),
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          text: course.completedChapters.toString(),
                          style: TextStyle(
                            color: HexColor('134C5D'),
                            fontSize: 24,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  '/${course.totalChapters.toString()} chapters completed',
                              style: const TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        // color: Colors.red,
                        width: 185,
                        height: 25,
                        child: Center(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: PercentageBar(
                              completedChapters: course.completedChapters,
                              totalChapters: course.totalChapters,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRoutes.Course_video_play);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(HexColor('FEFEFE')),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            minimumSize:
                                const WidgetStatePropertyAll(Size(200, 2))),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                              color: HexColor('515151'), fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              //2nd Column
              ,
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(2),
                  height: 234,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(width: 1.0, color: HexColor('1E1E1E'))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Column(
                      children: [
                        TaskCard(task: Task(day: 20, title: 'Build A project')),
                        Divider(
                          indent: 8,
                          endIndent: 8,
                          color: HexColor('134C5D'),
                        ),
                        TaskCard(task: Task(day: 21, title: 'Build A project')),
                        Divider(
                          indent: 8,
                          endIndent: 8,
                          color: HexColor('134C5D'),
                        ),
                        TaskCard(task: Task(day: 22, title: 'Build A project')),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 13, bottom: 14),
      child: RichText(
        text: TextSpan(
          text: task.day.toString(),
          style: TextStyle(
            color: HexColor('134C5D'),
            fontSize: 24,
            //fontWeight: f
          ),
          children: [
            const TextSpan(text: '  '),
            TextSpan(text: task.title, style: const TextStyle(fontSize: 12))
          ],
        ),
      ),
    );
  }
}

class Course {
  final String title;
  final int completedChapters;
  final int totalChapters;
  final IconData icon;
  final List<Task> tasks;

  Course(
      {required this.title,
      required this.completedChapters,
      required this.totalChapters,
      required this.icon,
      required this.tasks});
}

class Task {
  final int day;
  final String title;

  Task({required this.day, required this.title});
}
