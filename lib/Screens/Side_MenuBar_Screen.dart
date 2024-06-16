
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
    // Feedback(),
    // Ques
    
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
                      selectedImagePath: 'assets/icons/icon _leaderboard star_.png',
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
                      selectedImagePath: 'assets/icons/icon _question mark circle_.png',
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
              
     Container(
      margin: EdgeInsets.only(top:200),
       child: ListTile(
        title: ElevatedButton(
           style: ElevatedButton.styleFrom(
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
        backgroundColor: Color.fromARGB(255, 255, 255, 255), // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), 
            side: BorderSide(color: Colors.black)// Border radius
        ),
      ),
          onPressed: () {
          },
          child: Text("Login",style: GoogleFonts.poppins(),),
        ),
           ),
     ),
      Container(
      // margin: EdgeInsets.only(top:200),
       child: ListTile(
        title: ElevatedButton(
           style: ElevatedButton.styleFrom(
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
        backgroundColor: Color.fromARGB(255, 255, 255, 255), // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.black) // Border radius
        ),
      ),
          onPressed: () {
          },
          child: Text("Log out",style: GoogleFonts.poppins(),),
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

  // Function to build the AppBar
  AppBar buildAppBar(BuildContext context, double _widthFactor,
      double _heightFactor, String userName) {
    return AppBar(
      toolbarHeight: _heightFactor * 120,
      backgroundColor: Color.fromRGBO(62, 84, 204, 1),
      leadingWidth: _widthFactor * 273,
      leading: buildAppBarLeading(_widthFactor, _heightFactor),
    );
  }

  // Function to build the leading part of the AppBar
  Row buildAppBarLeading(double _widthFactor, double _heightFactor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
       
    Container(
      // padding: EdgeInsets.only(left: 70),
      margin: EdgeInsets.only(left: 10),
            // height: _heightFactor * 60,
            // width: _widthFactor * 60,
            child: Image.asset('assets/icons/Group 43 (2).png',),
          ),
        
        // Container(
        //   width: _widthFactor * 139,
        //   height: _heightFactor * 45,
        //   child: Theme.of(context).brightness == Brightness.light
        //       ? Image.asset('assets/logos/Kickoff.png')
        //       : Image.asset('assets/logos/KickoffD.png'),
        // ),
      ],
    );
  }

  // Function to build the actions part of the AppBar
  Widget buildAppBarActions(BuildContext context, double _widthFactor,
      double _heightFactor, bool isMorning, String userName) {

    return Padding(
      padding: EdgeInsets.fromLTRB(
        _widthFactor * 668,
        _heightFactor * 24,
        _widthFactor * 84,
        _heightFactor * 25,
      ),
      child: Row(
        children: [
          Container(
            height: _heightFactor * 70,
            width: _widthFactor * 140,
          
           
            // child: buildFlutterSwitch(_heightFactor, _widthFactor, status),
          ),
          buildColumn(
              context, _widthFactor, _heightFactor, isMorning, userName),
        ],
      ),
    );
  }


  // Function to build the column containing weather icon and greeting text
  Column buildColumn(BuildContext context, double _widthFactor,
      double _heightFactor, bool isMorning, String userName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: _widthFactor * 6),
          ],
        ),
        Text(
          "Name",
          // PreferencesManager().name,
          style: GoogleFonts.inter(
            textStyle: TextStyle(
              fontSize: 24 * _widthFactor * _heightFactor,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }

}
