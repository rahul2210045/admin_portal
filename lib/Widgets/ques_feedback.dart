// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;

// class ques_feedback extends StatefulWidget {
//   final String sequence;
//   final String question;
//   final VoidCallback onTap;
//   const ques_feedback(
//       {super.key,
//       required this.sequence,
//       required this.question,
//       required this.onTap});

//   @override
//   State<ques_feedback> createState() => _ques_feedbackState();
// }

// class _ques_feedbackState extends State<ques_feedback> {
//   final String quesId = '668904faacdcb68ea02c20a2';
//   final String question = 'How was the exam portal?';
//   @override
//   Widget build(BuildContext context) {
    
//     Future<void> updateFeedbackQuestion(String quesId, String question) async {
//       final url = Uri.parse(
//           'https://cine-admin-xar9.onrender.com/admin/feedback/updateFeedbackQuestion');
//       final body = jsonEncode({
//         'quesId': quesId,
//         'question': question,
//       });

//       final headers = {
//         'Content-Type': 'application/json',
//       };

//       try {
//         final response = await http.patch(
//           url,
//           headers: headers,
//           body: body,
//         );

//         if (response.statusCode == 200) {
//           print('Feedback question updated successfully');
//           print(response.body);
//         } else {
//           print('Failed to update feedback question: ${response.reasonPhrase}');
//         }
//       } catch (e) {
//         print('Error: $e');
//       }
//     }

//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//       child: Material(
//         borderRadius: BorderRadius.circular(12),
//         elevation: 2,
//         shadowColor: Colors.blueGrey,
//         child: ListTile(
//           contentPadding: EdgeInsets.all(12),
//           trailing: IconButton(
//               onPressed: widget.onTap,
//               icon: Icon(
//                 Icons.cancel,
//                 color: Color(0xffFF122E),
//               )),
//           title: Text(
//             "Question  " + widget.sequence,
//             style: GoogleFonts.poppins(fontSize: 16),
//           ),
//           subtitle: Row(
//             children: [
//               Text(widget.question, style: GoogleFonts.poppins(fontSize: 14)),
//               Row(
//                 children: [
                  
//                   Text("Tap here to edit",
//                       style: GoogleFonts.poppins(
//                           fontSize: 14, color: Colors.blue[800])),
//                 ],
//               ),
//             ],
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           tileColor: Colors.white,
//           enabled: true,
//            minTileHeight:20,
//         ),
//       ),
//     );
    
//   }
// }

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;

// class ques_feedback extends StatefulWidget {
//   final String sequence;
//   final String question;
//   final String quesId; // Added quesId
//   final VoidCallback onTap;
//   const ques_feedback(
//       {super.key,
//       required this.sequence,
//       required this.question,
//       required this.quesId, // Added quesId
//       required this.onTap});

//   @override
//   State<ques_feedback> createState() => _ques_feedbackState();
// }

// class _ques_feedbackState extends State<ques_feedback> {
//   final TextEditingController _editQuestionController = TextEditingController();
//     final String quesId = '668904faacdcb68ea02c20a2';


//   // API call to update feedback question
//   Future<void> updateFeedbackQuestion(String quesId,String newQuestion) async {
//     final url = Uri.parse(
//         'https://cine-admin-xar9.onrender.com/admin/feedback/updateFeedbackQuestion');
//     final body = jsonEncode({
//       'quesId': quesId,
//       'question': newQuestion,
//     });

//     final headers = {
//       'Content-Type': 'application/json',
//     };


//     try {
//       final response = await http.patch(
//         url,
//         headers: headers,
//         body: body,
//       );
//  print(response.statusCode);
//       if (response.statusCode == 200) {
//         print('Feedback question updated successfully');
//         print(response.body);
//       } else {
//         print('Failed to update feedback question: ${response.body}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   // Function to open the dialog and edit the question
//   void _openEditDialog() {
//          bool _isProcessing = false;
//     _editQuestionController.text = widget.question; // Pre-fill with current question

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Edit Question'),
//           content: TextField(
//             controller: _editQuestionController,
//             decoration: InputDecoration(
//               hintText: 'Enter new question',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
    

// TextButton(
//   onPressed: _isProcessing ? null : () async {
//     final newQuestion = _editQuestionController.text.trim();
//     if (newQuestion.isNotEmpty) {
//       setState(() { 
//           print("ffffffffffffffoiuytfvfff");
//           print('Updating question with quesId: $quesId');

//         _isProcessing = true; });
//       await updateFeedbackQuestion(widget.quesId,newQuestion);
//       setState(() {
//           print("09876543");
//          _isProcessing = false; });
//       Navigator.of(context).pop();
//       // Refresh UI or call _fetchFeedbacks() to reload the questions
//     }
//   },
//   child: _isProcessing ? CircularProgressIndicator() : Text('Update'),
// )

//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//       child: Material(
//         borderRadius: BorderRadius.circular(12),
//         elevation: 2,
//         shadowColor: Colors.blueGrey,
//         child: ListTile(
//           contentPadding: EdgeInsets.all(12),
//           trailing: IconButton(
//             onPressed: widget.onTap,
//             icon: Icon(
//               Icons.cancel,
//               color: Color(0xffFF122E),
//             ),
//           ),
//           title: Text(
//             "Question  " + widget.sequence,
//             style: GoogleFonts.poppins(fontSize: 16),
//           ),
//           subtitle: Row(
//             children: [
//               Expanded(
//                 child: Text(widget.question,
//                     style: GoogleFonts.poppins(fontSize: 14)),
//               ),
//               InkWell(
//                 onTap: _openEditDialog,
//                 child: Text("Tap here to edit",
//                     style: GoogleFonts.poppins(
//                         fontSize: 14, color: Colors.blue[800])),
//               ),
//             ],
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           tileColor: Colors.white,
//           enabled: true,
//           minVerticalPadding: 20,
//         ),
//       ),
//     );
//   }
// }



import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
class ques_feedback extends StatefulWidget {
  final String sequence;
  String question; // Make question mutable for updates
  final String quesId;
  final VoidCallback onTap;
  final VoidCallback onUpdate; // Callback to notify parent of update

  ques_feedback({
    super.key,
    required this.sequence,
    required this.question,
    required this.quesId,
    required this.onTap,
    required this.onUpdate, // Initialize the callback
  });

  @override
  State<ques_feedback> createState() => _ques_feedbackState();
}

class _ques_feedbackState extends State<ques_feedback> {
  final TextEditingController _editQuestionController = TextEditingController();
  bool _isUpdating = false;

  // API call to update feedback question
  Future<void> updateFeedbackQuestion(String quesId, String newQuestion) async {
    final url = Uri.parse(
        'https://cine-admin-xar9.onrender.com/admin/feedback/updateFeedbackQuestion');
    final body = jsonEncode({
      'quesId': quesId,
      'question': newQuestion,
    });

    final headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.patch(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print('Feedback question updated successfully');
        return;
      } else {
        print('Failed to update feedback question: ${response.body}');
        throw Exception('Failed to update feedback question');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error updating feedback question');
    }
  }

  // Function to open the dialog and edit the question
  void _openEditDialog() {
    _editQuestionController.text = widget.question; // Pre-fill with current question

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Edit Question'),
              content: TextField(
                controller: _editQuestionController,
                decoration: InputDecoration(
                  hintText: 'Enter new question',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    final newQuestion = _editQuestionController.text.trim();
                    if (newQuestion.isNotEmpty) {
                      setState(() {
                        _isUpdating = true;
                      });
                      try {
                        await updateFeedbackQuestion(widget.quesId, newQuestion);
                        setState(() {
                          _isUpdating = false;
                          widget.question = newQuestion; // Update local question
                        });
                        Navigator.of(context).pop();
                        // Notify parent to refresh the list
                        widget.onUpdate();
                      } catch (e) {
                        setState(() {
                          _isUpdating = false;
                        });
                      }
                    }
                  },
                  child: _isUpdating
                      ? CircularProgressIndicator()
                      : Text('Update'),
                )
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        elevation: 2,
        shadowColor: Colors.blueGrey,
        child: ListTile(
          contentPadding: EdgeInsets.all(12),
          trailing: IconButton(
            onPressed: widget.onTap,
            icon: Icon(
              Icons.cancel,
              color: Color(0xffFF122E),
            ),
          ),
          title: Text(
            "Question  " + widget.sequence,
            style: GoogleFonts.poppins(fontSize: 16),
          ),
          subtitle: Row(
            children: [
              Expanded(
                child: Text(widget.question,
                    style: GoogleFonts.poppins(fontSize: 14)),
              ),
              InkWell(
                onTap: _openEditDialog,
                child: Text("Tap here to edit",
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: Colors.blue[800])),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          tileColor: Colors.white,
          enabled: true,
          minVerticalPadding: 20,
        ),
      ),
    );
  }
}
