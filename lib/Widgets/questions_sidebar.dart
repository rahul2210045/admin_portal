import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/constants.dart';

class QuestionsSidebar extends StatefulWidget {


  const QuestionsSidebar({Key? key, }) : super(key: key);

  @override
  _QuestionsSidebarState createState() => _QuestionsSidebarState();
}

class _QuestionsSidebarState extends State<QuestionsSidebar> {
  int selectedIndex = -1; // Track selected index, -1 means none selected

  @override
  Widget build(BuildContext context) {
    double heightFactor = MediaQuery.of(context).size.height / 1024;
    double widthFactor = MediaQuery.of(context).size.width / 1440;

    return Column(
      children: [
        // Top "Question" label
        Container(
          width: double.infinity,
          height: heightFactor * 80,
          padding: EdgeInsets.all(10 * heightFactor),
          decoration: BoxDecoration(
            color: primaryColor, // Example primaryColor
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "Question",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 24 * widthFactor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 20 * heightFactor),

        // Grid of question numbers
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10 * heightFactor),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10 * heightFactor,
              crossAxisSpacing: 10 * widthFactor,
            ),
            itemCount: 10,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  width: 60 * widthFactor, // Adjust width as needed
                  height: 60 * heightFactor, // Adjust height as needed
                  margin: EdgeInsets.all(10), // Adjust margin as needed
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selectedIndex == index ? primaryColor : Colors.white, // Toggle color based on selection
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    index == 9 ? '+' : (index + 1).toString(),
                    style: TextStyle(
                      color: selectedIndex == index ? Colors.white : primaryColor,
                      fontSize: 18 * widthFactor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 40 * heightFactor),

        // Delete and Save buttons
        Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: widthFactor * 180,
                height: heightFactor * 70, // Set the desired width here
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor, // Example background color to blue
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Adjust border radius as needed
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20 * widthFactor,
                      vertical: 10 * heightFactor,
                    ),
                  ),
                  child: Text(
                    "Delete",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: widthFactor * 18,
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: widthFactor * 180,
                height: heightFactor * 70,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor, // Example background color to blue
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Adjust border radius as needed
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20 * widthFactor,
                      vertical: 10 * heightFactor,
                    ),
                  ),
                  child: Text(
                    "Save",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: widthFactor * 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
