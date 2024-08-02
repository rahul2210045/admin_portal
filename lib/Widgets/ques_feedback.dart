import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ques_feedback extends StatefulWidget {
  final String sequence;
  final String question;
  final VoidCallback onTap;
  const ques_feedback(
      {super.key,
      required this.sequence,
      required this.question,
      required this.onTap});

  @override
  State<ques_feedback> createState() => _ques_feedbackState();
}

class _ques_feedbackState extends State<ques_feedback> {
  final String quesId = '668904faacdcb68ea02c20a2';
  final String question = 'How was the exam portal?';
  @override
  Widget build(BuildContext context) {
    
    Future<void> updateFeedbackQuestion(String quesId, String question) async {
      final url = Uri.parse(
          'https://cine-admin-xar9.onrender.com/admin/feedback/updateFeedbackQuestion');
      final body = jsonEncode({
        'quesId': quesId,
        'question': question,
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
          print(response.body);
        } else {
          print('Failed to update feedback question: ${response.reasonPhrase}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }

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
              )),
          title: Text(
            "Question  " + widget.sequence,
            style: GoogleFonts.poppins(fontSize: 16),
          ),
          subtitle: Row(
            children: [
              Text(widget.question, style: GoogleFonts.poppins(fontSize: 14)),
              Row(
                children: [
                  
                  Text("Tap here to edit",
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.blue[800])),
                ],
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          tileColor: Colors.white,
          enabled: true,
          //  minTileHeight:20,
        ),
      ),
    );
    
  }
}
