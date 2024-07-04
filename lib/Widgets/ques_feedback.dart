import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ques_feedback extends StatefulWidget {
  final String sequence;
  final String question;
  const ques_feedback({super.key, required this.sequence, required this.question});

  @override
  State<ques_feedback> createState() => _ques_feedbackState();
}

class _ques_feedbackState extends State<ques_feedback> {
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
               
                Text("Tap here to edit",style: GoogleFonts.poppins(fontSize:14,color:Colors.blue[800]  )),
              ],
            ),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
        tileColor: Colors.white,
        enabled: true,
        minTileHeight:20,
           
        
        
        ),
      ),
    ); ;
  }
}