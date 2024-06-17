import 'package:admin_portal/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class feedback_page extends StatefulWidget {
  const feedback_page({super.key});

  @override
  State<feedback_page> createState() => _feedback_pageState();
}

class _feedback_pageState extends State<feedback_page> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      //backgroundColor: backgroundColor1,
      body: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.015),
            child: Container(
              color: Colors.grey[300],
              width: screenWidth * 0.49,
              height: screenHeight * 0.80,
              //child: Column(
               // children: [
                 // Row(
                  //  children: [
                      //first box
                //       Column(children: [
                //         Text("Name"),
                //         SizedBox(
                //           child: Container(
                //             decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: BorderRadius.circular(6),
                //               border:Border.all(color: Colors.black),
                //             ),
                //             child: Center(child: Text("Ashirwad")),
                //           ),
                //           height: 27,
                //           width: 120,
                //         )
                //       ]),
                //       //second box
                //        Column(children: [
                //         Text("Name"),
                //         SizedBox(
                //           child: Container(
                //             decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: BorderRadius.circular(6),
                //               border:Border.all(color: Colors.black),
                //             ),
                //             child: Center(child: Text("Ashirwad")),
                //           ),
                //           height: 27,
                //           width: 120,
                //         )
                //       ]),
                //     ],
                //   ),


                // Row(
                //     children: [
                //       //first box
                //       Column(children: [
                //         Text("Name"),
                //         SizedBox(
                //           child: Container(
                //             decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: BorderRadius.circular(6),
                //               border:Border.all(color: Colors.black),
                //             ),
                //             child: Center(child: Text("Ashirwad")),
                //           ),
                //           height: 27,
                //           width: 120,
                //         )
                //       ]),
                //       //second box
                //        Column(children: [
                //         Text("Name"),
                //         SizedBox(
                //           child: Container(
                //             decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: BorderRadius.circular(6),
                //               border:Border.all(color: Colors.black),
                //             ),
                //             child: Center(child: Text("Ashirwad")),
                //           ),
                //           height: 27,
                //           width: 120,
                //         )
                //       ]),
                //     ],
                //   ),



                //   Row(
                //     children: [
                //       //first box
                //       Column(children: [
                //         Text("Name"),
                //         SizedBox(
                //           child: Container(
                //             decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: BorderRadius.circular(6),
                //               border:Border.all(color: Colors.black),
                //             ),
                //             child: Center(child: Text("Ashirwad")),
                //           ),
                //           height: 27,
                //           width: 120,
                //         )
                //       ]),
                //     ],
                //   ),


                //   Row(
                //     children: [
                //       //first box
                //       Column(children: [
                //         Text("Name"),
                //         SizedBox(
                //           child: Container(
                //             decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: BorderRadius.circular(6),
                //               border:Border.all(color: Colors.black),
                //             ),
                //             child: Center(child: Text("Ashirwad")),
                //           ),
                //           height: 150,
                //           width: 350,
                //         )
                //       ]),
                //     ],
                //   ),





              //  ],
             // ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.015),
            child: Container(
              color: Colors.grey[300],
              child: Column(
                children: [
                  Container(
                    child: Center(
                        child: Text(
                      "Feedback",
                      style: TextStyle(color: Colors.white),
                    )),
                    color: Colors.black,
                    height: screenHeight * 0.06,
                    width: screenWidth * 0.23,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Student Name: Ashirwad Gupta"),
                ],
              ),
              width: screenWidth * 0.23,
              height: screenHeight * 0.80,
            ),
          ),
        ],
      ),
    );
  }
}
