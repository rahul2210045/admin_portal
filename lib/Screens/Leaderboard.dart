import 'package:admin_portal/Widgets/Custom_Container.dart';
import 'package:admin_portal/Widgets/Screensize.dart';
import 'package:admin_portal/constants/constants.dart';
import 'package:flutter/material.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
       body: SingleChildScrollView(
         child: Row(
           children: [
             Column(
               children: [
                 CustomRoundedContainer(child: Text("Static"), height: heightFactor(context)*420, width: widthFactor(context)*450,padding: EdgeInsets.all(10),margin: EdgeInsets.only(top: 20),),
                  CustomRoundedContainer(child: Text("0987654"), height: heightFactor(context)*420, width: widthFactor(context)*450,padding: EdgeInsets.all(10),margin: EdgeInsets.only(top: 20,bottom: 10),)
               ],
               
             ),
              CustomRoundedContainer(child: Text("asdfghjk"), height: heightFactor(context)*858, width: widthFactor(context)*700,padding: EdgeInsets.all(10),margin: EdgeInsets.only(top: 20,left: 20),)
           ],
         ),
       ),
       
    );
  }
}