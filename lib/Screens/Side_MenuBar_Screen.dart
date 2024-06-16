import 'package:admin_portal/Screens/Candidate.dart';
import 'package:admin_portal/Screens/Leaderboard.dart';
import 'package:admin_portal/Screens/Questions.dart';
import 'package:admin_portal/Widgets/Customtextbutton.dart';
import 'package:admin_portal/Widgets/Screensize.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class sidemenubar extends StatefulWidget {
  String userName;
  sidemenubar({super.key, required this.userName});
  @override
  _sidemenubarState createState() => _sidemenubarState();
}

class _sidemenubarState extends State<sidemenubar> {
  String? globalUserImage;
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Leaderboard(),
    Candidate(),
    Questions(),
    Questions()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double _widthFactor = widthFactor(context);
    double _heightFactor = heightFactor(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(215, 219, 244, 1),
      appBar:
          buildAppBar(context, _widthFactor, _heightFactor, widget.userName),
      body: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(
                0, 0, 16, 0), // Set the desired left padding
            child: Container(
              width: 250, // Increased width of the side menu
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .onPrimary, // Background color of the side menu
                // borderRadius: BorderRadius.circular(
                //     20.0), // Rounded corners for all four corners
              ),
              padding: const EdgeInsets.all(15),
              // margin:EdgeInsets.fromLTRB(0, 90, 0, 4),
              child: ListView(
                children: <Widget>[
                  const Padding(padding: EdgeInsets.all(4)),
                  ListTile(
                    title: CustomTextButton(
                      text: "Leader Board",
                      isSelected: _selectedIndex == 0,
                      onPressed: () {
                        _onItemTapped(0);
                      },
                      imagePath: 'assets/icons/icon _leaderboard star_.png',
                      selectedImagePath:
                          'assets/icons/icon _leaderboard star_.png',
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(4)),
                  ListTile(
                    title: CustomTextButton(
                      text: "Candidates",
                      isSelected: _selectedIndex == 1,
                      onPressed: () {
                        _onItemTapped(1);
                      },
                      imagePath: 'assets/icons/icon _Users_.png',
                      selectedImagePath: 'assets/icons/icon _Users_.png',
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(4)),
                  ListTile(
                    title: CustomTextButton(
                      text: "Questions",
                      isSelected: _selectedIndex == 2,
                      onPressed: () {
                        _onItemTapped(2);
                      },
                      imagePath: 'assets/icons/icon _question mark circle_.png',
                      selectedImagePath:
                          'assets/icons/icon _question mark circle_.png',
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(4)),
                  ListTile(
                    title: CustomTextButton(
                      text: "Feedback",
                      isSelected: _selectedIndex == 3,
                      onPressed: () {
                        _onItemTapped(3);
                      },
                      imagePath: 'assets/icons/Vector (2).png',
                      selectedImagePath: 'assets/icons/Vector (2).png',
                    ),
                  ),
                  SizedBox(height: 200,),
                  Spacer(),
                  // Container(
                  //   margin: EdgeInsets.only(top: 200),
                  //   child: ListTile(
                  //     title: ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //         foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                  //         backgroundColor:
                  //             Color.fromARGB(255, 255, 255, 255), // Text color
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(8),
                  //             side: BorderSide(
                  //                 color: Colors.black) // Border radius
                  //             ),
                  //       ),
                  //       onPressed: () {},
                  //       child: Text(
                  //         "Login",
                  //         style: GoogleFonts.poppins(),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    // margin: EdgeInsets.only(top:200),
                    child: ListTile(
                      title: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor:
                              Color.fromARGB(255, 255, 255, 255), // Text color
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                  color: Colors.black) // Border radius
                              ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Log out",
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // VerticalDivider(), // Optional: add a vertical divider between side menu and content
          Expanded(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, double _widthFactor,
      double _heightFactor, String userName) {
    return AppBar(
      toolbarHeight: _heightFactor * 120,
      backgroundColor: Color.fromRGBO(62, 84, 204, 1),
      leadingWidth: _widthFactor * 273,
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(left: 40 * widthFactor(context))),
          Image.asset(
            'assets/icons/Group 43 (2).png',
            height: _heightFactor *
                200, // Adjust the height of the image responsively
            width: _widthFactor *
                200, // Adjust the width of the image responsively
          ),
        ],
      ),
    );
  }
}
