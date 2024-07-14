import 'package:admin_portal/Widgets/Customized_Loader.dart';
import 'package:admin_portal/main.dart';
import 'package:flutter/material.dart';


void main() async {
  runApp(const MyApp());
}
class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

 
class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:CustomLoader()
      ),
    );
  }
}