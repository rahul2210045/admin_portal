import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ques_feedback extends StatefulWidget {
  final String sequence;
  final String question;
  const ques_feedback({super.key, required this.sequence, required this.question});

  @override
  State<ques_feedback> createState() => _ques_feedbackState();
}

class _ques_feedbackState extends State<ques_feedback> {
  Future<void> updateFeedbackQuestion(String quesId, String question) async {
  final url = 'https://cine-admin-xar9.onrender.com/admin/feedback/updateFeedbackQuestion';
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({
    'quesId': quesId,
    'question': question,
  });

  try {
    final response = await http.patch(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      // Request was successful
      print('Feedback question updated successfully');
    } else {
      // Request failed
      print('Failed to update feedback question');
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical:8,horizontal: 10),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        elevation: 2,
        shadowColor: Colors.blueGrey,
        child: ListTile(
          
          contentPadding: EdgeInsets.all(12),
          trailing: IconButton(onPressed: (){}, icon: Icon(Icons.cancel,color: Color(0xffFF122E),)),
        title: Text("Question  "+widget.sequence,style: GoogleFonts.poppins(fontSize:16 ),),
        subtitle: Row(
          children: [
            Text(widget.question,style: GoogleFonts.poppins(fontSize:14 )),
            Row(
              children: [
               
               GestureDetector(
            onTap: () {
              updateFeedbackQuestion('668807ab988f8cf515a41bc0', 'how was the exam portal?');
  
              // You can call your updateFeedbackQuestion function here
              // updateFeedbackQuestion('668807ab988f8cf515a41bc0', 'how was the exam portal?');
            },
            child: Text(
              "Tap here to edit",
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.blue[800]),
            ),
          ),
              ],
            ),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
        tileColor: Colors.white,
        enabled: true,
        // minTileHeight:20,
           
        
        
        ),
      ),
    ); ;
  }
}