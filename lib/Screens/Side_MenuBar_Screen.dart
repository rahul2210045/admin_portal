import 'package:admin_portal/Screens/Feedback.dart';
import 'package:admin_portal/Screens/Leaderboard.dart';
import 'package:admin_portal/Screens/questions_page.dart';
import 'package:admin_portal/Widgets/Screensize.dart';
import 'package:admin_portal/screens/Candidate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/constants.dart';
import 'candidate_add.dart';

class SideMenuBar extends StatefulWidget {
  final String userName;

  const SideMenuBar({Key? key, required this.userName}) : super(key: key);

  @override
  _SideMenuBarState createState() => _SideMenuBarState();
}

class _SideMenuBarState extends State<SideMenuBar> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Leaderboard(),
    candidate(),
    QuestionScreen(),
    feedback_page(),
    candidateAdd(),
  ];

  void _onItemTapped(int index) {
    if (index == 4) {
      _handleLogout();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _handleLogout() {
    print("Logged out");
  }

  @override
  Widget build(BuildContext context) {
    double _widthFactor = widthFactor(context);
    double _heightFactor = heightFactor(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(215, 219, 244, 1),
      appBar: buildAppBar(context, _widthFactor, _heightFactor),
      body: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 16 * _widthFactor, 0),
            child: Container(
              width: 200 * _widthFactor,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              padding: EdgeInsets.fromLTRB(10 * _widthFactor, 25 * _widthFactor,
                  10 * _widthFactor, 25 * _widthFactor),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        buildListTile(
                            "Leader Board",
                            'assets/icons/icon _leaderboard starPurple_.png',
                            'assets/icons/LeaderboardWhite.png',
                            0,
                            _widthFactor,
                            _heightFactor),
                        SizedBox(height: 4 * _heightFactor),
                        buildListTile(
                            "Candidates",
                            'assets/icons/icon _UsersPurple_.png',
                            'assets/icons/CandidatesWhite.png',
                            1,
                            _widthFactor,
                            _heightFactor),
                        SizedBox(height: 4 * _heightFactor),
                        buildListTile(
                            "Questions",
                            'assets/icons/icon _question mark circlePurple_.png',
                            'assets/icons/icon _question mark circlePurple_.png',
                            2,
                            _widthFactor,
                            _heightFactor),
                        SizedBox(height: 4 * _heightFactor),
                        buildListTile(
                            "Feedback",
                            'assets/icons/icon _Person FeedbackPurple_.png',
                            'assets/icons/FeedbackWhite.png',
                            3,
                            _widthFactor,
                            _heightFactor),
                        SizedBox(height: 12 * _heightFactor),
                      ],
                    ),
                  ),
                  buildListTile(
                      "Log out",
                      'assets/icons/Group 54.png',
                      'assets/icons/Group 54.png',
                      4,
                      _widthFactor,
                      _heightFactor),
                ],
              ),
            ),
          ),
          Expanded(
            child: Navigator(
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (_) => _widgetOptions.elementAt(_selectedIndex),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListTile(
      String text,
      String iconPathUnselected,
      String iconPathSelected,
      int index,
      double widthFactor,
      double heightFactor) {
    return Container(
      decoration: BoxDecoration(
        color: _selectedIndex == index ? primaryColor : null,
        borderRadius: BorderRadius.circular(15 * widthFactor),
      ),
      child: ListTile(
        title: Row(
          children: [
            if (iconPathUnselected.isNotEmpty) ...[
              Image.asset(
                _selectedIndex == index ? iconPathSelected : iconPathUnselected,
                scale: 5.5,
              ),
              SizedBox(width: 7 * widthFactor),
            ],
            Flexible(
              child: Tooltip(
                message: text,
                child: Text(
                  text,
                  style: GoogleFonts.poppins(
                    color:
                        _selectedIndex == index ? Colors.white : primaryColor,
                    fontSize: 14 * widthFactor,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          _onItemTapped(index);
        },
      ),
    );
  }

  AppBar buildAppBar(
      BuildContext context, double _widthFactor, double _heightFactor) {
    return AppBar(
      toolbarHeight: _heightFactor * 120,
      backgroundColor: primaryColor,
      leadingWidth: _widthFactor * 380,
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(padding: EdgeInsets.only(left: 50 * _widthFactor)),
          Image.asset(
            'assets/icons/CSI LOGO.png',
            scale: 5,
          ),
          Text(
            'CSI Exam Portal',
            style: GoogleFonts.poppins(
              fontSize: 30 * _widthFactor,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
