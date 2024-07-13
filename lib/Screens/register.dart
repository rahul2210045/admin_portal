import 'package:admin_portal/Widgets/Custom_Container.dart';
import 'package:admin_portal/Widgets/Screensize.dart';
import 'package:admin_portal/components/custom_detail_card.dart';
import 'package:admin_portal/components/custom_register_card.dart';
import 'package:admin_portal/constants/constants.dart';
import 'package:flutter/material.dart';

class registerTabel extends StatelessWidget {
  const registerTabel({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      color: primaryColor,
                    ),
                    width: widthFactor(context) * 770,
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "  Registered Candidate's",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        // Container(
                        //   height: 50,
                        //   width: widthFactor(context) * 530,
                        //   child: Row(
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Container(
                        //         // height: 50,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(10),
                        //           border: Border.all(
                        //             color: Colors.grey.shade600,
                        //           ),
                        //           color: Colors.white,
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.grey.shade100,
                        //               blurRadius: 100.0,
                        //               spreadRadius: 0.0,
                        //               offset: Offset(1.0, 1.0),
                        //             )
                        //           ],
                        //         ),
                        //         height: 40,
                        //         width: widthFactor(context) * 480,
                        //         // height: screenHeight*0.01,
                        //         child: TextField(
                        //           style: TextStyle(color: Colors.white),
                        //           decoration: InputDecoration(
                        //             suffix: const Icon(
                        //               Icons.search_rounded,
                        //               color: Colors.grey,
                        //             ),
                        //             contentPadding: const EdgeInsets.symmetric(
                        //                 horizontal: 20),
                        //             labelText: "Search something here...",
                        //             border: OutlineInputBorder(
                        //                 borderSide: BorderSide(
                        //                   color: dividerColor,
                        //                 ),
                        //                 borderRadius:
                        //                     BorderRadius.circular(10)),
                        //           ),
                        //         ),
                        //       ),
                        //       // const SizedBox(
                        //       //   width: 15,
                        //       // ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10),
                    child: Container(
                      width: widthFactor(context) * 750,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            blurRadius: 10.0,
                            spreadRadius: 0.5,
                            offset: Offset(1.0, 1.0),
                          )
                        ],
                        color: Colors.white,
                      ),
                      child: const Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Student Name",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Student No.",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Branch",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        customRegisterCard("rahul", "2210045", "CSE", context)
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}