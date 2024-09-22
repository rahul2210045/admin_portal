import 'package:admin_portal/Widgets/Screensize.dart';
import 'package:admin_portal/components/socketmanager.dart';
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
  List<LeaderboardEntry> filteredLeaderboard = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    socket = SocketManager().getSocket();

    setState(() {
      isLoading = true;
    });

    socket.on('leaderboard', (data) {
      print('Received leaderboard data: $data');
      setState(() {
        leaderboard = parseLeaderboardData(data);
        filteredLeaderboard = leaderboard;
        isLoading = false;
      });
    });

    searchController.addListener(() {
      filterLeaderboard();
    });
  }

  List<LeaderboardEntry> parseLeaderboardData(dynamic data) {
    final jsonData = data as List;
    return jsonData.map((item) => LeaderboardEntry.fromJson(item)).toList();
  }

  void filterLeaderboard() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredLeaderboard = leaderboard.where((entry) {
        return entry.name.toLowerCase().contains(query) ||
            entry.studentNumber.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    socket.off('leaderboard');
    searchController.dispose();
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // SizedBox(width: 5,),
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
                                controller: searchController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  suffix: const Icon(
                                    Icons.search_rounded,
                                    color: Colors.grey,
                                  ),
                                  contentPadding:
                                      const EdgeInsets.symmetric(horizontal: 20),
                                  hintText: "Search by name or student number...",
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
                isLoading
                    ? Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 150),
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            
                            color: Colors.white,
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                            columnSpacing: 100, 

                              columns: const [
                                DataColumn(label: Text('Rank', style: TextStyle(fontWeight: FontWeight.bold))),
                                DataColumn(label: Text('Student Name', style: TextStyle(fontWeight: FontWeight.bold))),
                                DataColumn(label: Text('Score', style: TextStyle(fontWeight: FontWeight.bold))),
                                DataColumn(label: Text('Branch', style: TextStyle(fontWeight: FontWeight.bold))),
                                DataColumn(label: Text('Student No.', style: TextStyle(fontWeight: FontWeight.bold))),
                                // DataColumn(label: Text('Gender', style: TextStyle(fontWeight: FontWeight.bold))),
                                // DataColumn(label: Text('Residency', style: TextStyle(fontWeight: FontWeight.bold))),
                              ],
                              rows: filteredLeaderboard.asMap().entries.map((entry) {
                                return DataRow(cells: [
                                  DataCell(Text((entry.key + 1).toString())),
                                  DataCell(Text(entry.value.name)),
                                  DataCell(Text(entry.value.score.toString())),
                                  DataCell(Text(entry.value.branch)),
                                  DataCell(Text(entry.value.studentNumber)),
                                  // DataCell(Text(entry.value.gender)),
                                  // DataCell(Text(entry.value.residency)),
                                ]);
                              }).toList(),
                            ),
                          ),
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