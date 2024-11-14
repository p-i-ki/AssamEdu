import 'package:assam_edu/core/utlis/percentage_bar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class VideoPlaySection extends StatefulWidget {
  const VideoPlaySection({super.key});

  @override
  State<VideoPlaySection> createState() => _VideoPlaySectionState();
}

class _VideoPlaySectionState extends State<VideoPlaySection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('FFFFFF'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30, left: 5, right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 30, top: 20),
              child: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.black,
              ),
            ),
            Container(
              height: 220,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: HexColor('DFF8FF'),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Python Course',
                        style: TextStyle(
                            color: HexColor('134C5D'),
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'by Nila Man',
                        style: TextStyle(
                          color: HexColor('134C5D'),
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 30),
                      RichText(
                        text: TextSpan(
                          text: '20',
                          style: TextStyle(
                            color: HexColor('134C5D'),
                            fontSize: 24,
                          ),
                          children: const [
                            TextSpan(
                              text: '/40 chapters completed',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 3),
                      const SizedBox(
                        // color: Colors.red,
                        width: 160,
                        height: 25,
                        child: Center(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: PercentageBar(
                              completedChapters: 9,
                              totalChapters: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  Container(
                    height: 200,
                    width: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        image: const DecorationImage(
                            image: AssetImage('assets/pyhton.jpg'),
                            fit: BoxFit.fill)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 500,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: HexColor('FFF0D3'),
              ),
              child: ListView.builder(
                  padding: const EdgeInsets.only(left: 22, top: 8, bottom: 5),
                  itemCount: 10,
                  itemBuilder: (_, index) {
                    int a = index + 1;
                    return Container(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.check_box_outlined,
                                size: 24,
                                color: HexColor('515151'),
                              ),
                              const SizedBox(width: 2),
                              Text(
                                '$a. Introduction to Python',
                                style: TextStyle(
                                    fontSize: 14, color: HexColor('515151')),
                              ),
                              Expanded(child: Container()),
                              Icon(
                                Icons.file_download_outlined,
                                size: 20,
                                color: HexColor('515151'),
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                Icons.note_add_outlined,
                                size: 20,
                                color: HexColor('515151'),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 35.0, right: 4),
                                child: Icon(
                                  Icons.play_circle_fill,
                                  size: 20,
                                  color: HexColor('515151'),
                                ),
                              ),
                              Text(
                                '8 min',
                                style: TextStyle(
                                    color: HexColor('515151'), fontSize: 10),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor('134C5D'),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4))),
                  child: Text(
                    'Get Certificate',
                    style: TextStyle(
                      fontSize: 16,
                      color: HexColor('FDF5E7'),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
