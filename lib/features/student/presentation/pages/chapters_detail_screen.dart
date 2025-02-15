import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ChaptersScreen extends StatefulWidget {
  const ChaptersScreen({super.key});

  @override
  State<ChaptersScreen> createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends State<ChaptersScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('FFFFFF'),
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(30), child: AppBar()),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1),
                    //color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 15, left: 20, right: 10),
                        child: Text(
                          'Python Basics to Advance',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: HexColor('134C5D'),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                            padding: const EdgeInsets.only(
                                left: 22, top: 8, bottom: 5),
                            itemCount: 20,
                            itemBuilder: (context, index) {
                              int a = index + 1;
                              return InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '$a. chapter name',
                                    style: TextStyle(
                                        color: HexColor('134C5D'),
                                        fontSize: 18),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
