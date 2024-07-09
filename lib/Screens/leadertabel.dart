// import 'package:admin_portal/Widgets/Screensize.dart';
// import 'package:admin_portal/components/custom_detail_card.dart';
// import 'package:admin_portal/constants/constants.dart';
// import 'package:flutter/material.dart';

// class LeaderTabel extends StatefulWidget {
//   const LeaderTabel({super.key});

//   @override
//   State<LeaderTabel> createState() => _LeaderTabelState();
// }

// class _LeaderTabelState extends State<LeaderTabel> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(10),
//                           topRight: Radius.circular(10)),
//                       color: primaryColor,
//                     ),
//                     width: widthFactor(context) * 700,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "  LeaderBoard",
//                           style: TextStyle(color: Colors.white, fontSize: 20),
//                         ),
//                         Container(
//                           height: 50,
//                           width: widthFactor(context) * 530,
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 // height: 50,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   border: Border.all(
//                                     color: Colors.grey.shade600,
//                                   ),
//                                   color: Colors.white,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey.shade100,
//                                       blurRadius: 100.0,
//                                       spreadRadius: 0.0,
//                                       offset: Offset(1.0, 1.0),
//                                     )
//                                   ],
//                                 ),
//                                 height: 40,
//                                 width: widthFactor(context) * 400,
//                                 // height: screenHeight*0.01,
//                                 child: TextField(
//                                   style: TextStyle(color: Colors.white),
//                                   decoration: InputDecoration(
//                                     suffix: const Icon(
//                                       Icons.search_rounded,
//                                       color: Colors.grey,
//                                     ),
//                                     contentPadding: const EdgeInsets.symmetric(
//                                         horizontal: 20),
//                                     labelText: "Search something here...",
//                                     border: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                           color: dividerColor,
//                                         ),
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                   ),
//                                 ),
//                               ),
//                               // const SizedBox(
//                               //   width: 15,
//                               // ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 5.0, horizontal: 10),
//                     child: Container(
//                       width: widthFactor(context) * 680,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(10),
//                             topRight: Radius.circular(10)),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.shade500,
//                             blurRadius: 10.0,
//                             spreadRadius: 0.5,
//                             offset: Offset(1.0, 1.0),
//                           )
//                         ],
//                         color: Colors.white,
//                       ),
//                       child: const Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10.0, vertical: 5),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "Rank",
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               "Student Name",
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               "Student No.",
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10.0, vertical: 5),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         customRankCard("rahul", "2210045", "1", context)
//                       ],
//                     ),
//                   )
//                 ],
//               )),
//         ),
//       ),
//     );
//   }
// }
import 'package:admin_portal/Widgets/Screensize.dart';
import 'package:admin_portal/components/custom_detail_card.dart';
import 'package:admin_portal/constants/constants.dart';
import 'package:admin_portal/repository/models/LeaderboardEntry.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class LeaderTabel extends StatefulWidget {
  const LeaderTabel({super.key});

  @override
  _LeaderTabelState createState() => _LeaderTabelState();
}

class _LeaderTabelState extends State<LeaderTabel> {
  late IO.Socket socket;
  List<LeaderboardEntry> leaderboard = [];

  @override
  void initState() {
    super.initState();
    initSocket();
  }

  void initSocket() {
    socket = IO.io('https://cine-admin-xar9.onrender.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.on('connect', (_) {
      print('Connected to server');
     
    });

    socket.on('leaderboard', (data) {
      print('Received leaderboard data: $data');
      setState(() {
        leaderboard = parseLeaderboardData(data);
      });
    });

    socket.connect();
  }

  List<LeaderboardEntry> parseLeaderboardData(dynamic data) {
    final jsonData = data as List;
    return jsonData.map((item) => LeaderboardEntry.fromJson(item)).toList();
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                  width: widthFactor(context) * 700,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "  LeaderBoard",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Container(
                        height: 50,
                        width: widthFactor(context) * 530,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey.shade600,
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade100,
                                    blurRadius: 100.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(1.0, 1.0),
                                  )
                                ],
                              ),
                              height: 40,
                              width: widthFactor(context) * 400,
                              child: TextField(
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  suffix: const Icon(
                                    Icons.search_rounded,
                                    color: Colors.grey,
                                  ),
                                  contentPadding:
                                      const EdgeInsets.symmetric(horizontal: 20),
                                  labelText: "Search something here...",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: dividerColor,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                  child: Container(
                    width: widthFactor(context) * 680,
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
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rank",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Student Name",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                             Text(
                            "Score",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                             Text(
                            "branch",
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
                            "Gender",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                            Text(
                            "Residency",
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: leaderboard
                        .asMap()
                        .entries
                        .map((entry) => customRankCard(
                           
                              entry.value.name,
                              
                            
                              entry.value.studentNumber,
                               (entry.key + 1).toString(),
                                 entry.value.score.toString(),
                                 entry.value.branch,
                                 entry.value.gender,
                                 entry.value.residency,

                            
                              context,
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
