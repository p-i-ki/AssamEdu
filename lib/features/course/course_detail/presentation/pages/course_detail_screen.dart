import 'package:assam_edu/core/routes/names.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({super.key});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('FFFFFF'),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: AppBar(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 4, right: 4),
              height: 220,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  //color: HexColor('FFF0D3'),
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/python_course.jpg',
                      ))),
              child: const Padding(
                padding: EdgeInsets.only(left: 15.0, top: 2),
                child: Text(
                  'Python Basics to Advanced',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 500,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: HexColor('3572EF'),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                            text: '12',
                            style: TextStyle(
                                color: HexColor('FFFFFF'),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                            children: const [
                              TextSpan(
                                  text: ' hours',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal))
                            ]),
                      ),
                      Expanded(child: Container()),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Rs 3999',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    //  mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: '52',
                            style: TextStyle(
                                color: HexColor('FFFFFF'),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                            children: const [
                              TextSpan(
                                text: ' chapters',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ]),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRoutes.Chapter_Detail_Page);
                        },
                        icon: const Icon(
                          Icons.play_circle_fill_sharp,
                          size: 20,
                          color: Colors.black,
                        ),
                        tooltip: 'See the chapters',
                      ),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'MEDIUM',
                        style: TextStyle(
                          color: HexColor('FFFFFF'),
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                        children: const [
                          TextSpan(
                              text: ' level',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.normal))
                        ]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "this is the best course in python by Nila Man a student of JEC and best friend of Maina , hope you will like this course . this course covers python basic to advance,you will learn various things such as loops, variables, switch-cases, array , Objects , OOPs also some important concepts of machine learning such as Numpy , Pandas etc...",
                    style: TextStyle(
                      fontSize: 12,
                      color: HexColor('FFFFFF'),
                    ),
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 15),
                  RichText(
                    text: TextSpan(
                        text: 'Joypal Taid',
                        style: TextStyle(
                            color: HexColor('FFFFFF'),
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                              text: ' Educator',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: HexColor('FFFFFF')))
                        ]),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(left: 230),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Similar courses',
                          style: TextStyle(
                              color: HexColor('000000'),
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  Text(
                    'Demo Materials',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: HexColor('FFFFFF'),
                        height: 0),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemExtent: 30,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'A brief introduction to python - 12 minutes',
                                style: TextStyle(
                                    color: HexColor('FFFFFF'), fontSize: 12),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.play_circle_fill,
                                  size: 16,
                                ),
                              ),
                            ],
                          );
                        }),
                  )
                ],
              ),
            ),
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: HexColor('FFFFFF'),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 1.5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        text: '4.7',
                        style: TextStyle(
                            color: HexColor('000000'),
                            fontSize: 30,
                            fontWeight: FontWeight.w700),
                        children: [
                          TextSpan(
                              text: '/5',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: HexColor('000000'))),
                        ]),
                  ),
                  Text(
                    'See what others have to say about this course',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: HexColor('000000')),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: ListView.builder(
                        //  physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(8),
                            height: 65,
                            width: 170,
                            decoration: BoxDecoration(
                                color: HexColor('FFFFFF'),
                                borderRadius: BorderRadius.circular(6),
                                border:
                                    Border.all(color: Colors.black, width: 1)),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  foregroundImage: const AssetImage(
                                    'assets/images/person.jpeg',
                                  ),
                                  backgroundColor: Colors.grey.shade600,
                                  maxRadius: 25,
                                ),
                                Text(
                                  'Ricky Boruah',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: HexColor('515151'),
                                  ),
                                ),
                                Text(
                                  'This is the best python course in the world, this course clears all my doubts',
                                  maxLines: 3,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: HexColor('515151'), fontSize: 7),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: BorderSide.none),
                      backgroundColor: HexColor('050C9C'),
                      padding: const EdgeInsets.all(8),
                    ),
                    child: const Text(
                      'Add to cart',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      side: BorderSide(color: HexColor('050C9C'), width: 2),
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(8),
                    ),
                    child: Text(
                      'Buy',
                      style: TextStyle(
                          color: HexColor('050C9C'),
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
