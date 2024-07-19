import 'package:admin_portal/Screens/Side_MenuBar_Screen.dart';
import 'package:admin_portal/repository/models/LoginApi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _apiService = LoginApi();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isUsernameEmpty = false;
  bool _isPasswordEmpty = false;
  

//   void _login() async {
//     final username = _usernameController.text;
//     final password = _passwordController.text;
//      setState(() {
//       _isUsernameEmpty = username.isEmpty;
//       _isPasswordEmpty = password.isEmpty;
//     });

//     // Validation
//     if (username.isEmpty || password.isEmpty) {
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     try {
//       final success = await _apiService.login(username, password);
//       setState(() {
//         _isLoading = false;
//       });

//       if (success) {
        
//         // ScaffoldMessenger.of(context).showSnackBar(
//         //   SnackBar(content: Text('Login successful')),
//         // );
//             toastification.show(
//   context: context, // optional if you use ToastificationWrapper
//   type: ToastificationType.success,
//   style: ToastificationStyle.flatColored,
//   autoCloseDuration: const Duration(seconds: 5),
//   title: Text('Login successful'),
//   alignment: Alignment.topRight,
//   direction: TextDirection.ltr,
//   animationDuration: const Duration(milliseconds: 300),
//   // animationBuilder: (context, animation, alignment, child) {
//   //   // return FadeTransition(
//   //   //   turns: animation,
//   //   //   child: child,
//   //   // );
//   // },
//   icon: const Icon(Icons.check),
//   primaryColor: Colors.green,
//   backgroundColor: Colors.white,
//   foregroundColor: Colors.black,
//   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//   margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//   borderRadius: BorderRadius.circular(12),
//   boxShadow: const [
//     BoxShadow(
//       color: Color(0x07000000),
//       blurRadius: 16,
//       offset: Offset(0, 16),
//       spreadRadius: 0,
//     )
//   ],
//   showProgressBar: true,
//   closeButtonShowType: CloseButtonShowType.onHover,
//   closeOnClick: false,
//   pauseOnHover: true,
//   dragToClose: true,
//   applyBlurEffect: true,
//   callbacks: ToastificationCallbacks(
//     onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
//     onCloseButtonTap: (toastItem) => print('Toast ${toastItem.id} close button tapped'),
//     onAutoCompleteCompleted: (toastItem) => print('Toast ${toastItem.id} auto complete completed'),
//     onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
//   ),
// );
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => SideMenuBar(userName: username)),
//         );
//       } else {
//         _showErrorDialog('Login failed. Please check your credentials and try again.');
//       }
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       _showErrorDialog('An error occurred. Please try again.');
//       print('Error during login: $e');
//     }
//   }

  void _showErrorDialog(String message) {
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text('Error'),
    //       content: Text(message),
    //       actions: [
    //         TextButton(
    //           child: Text('OK'),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
    toastification.show(
  context: context, // optional if you use ToastificationWrapper
  type: ToastificationType.success,
  style: ToastificationStyle.flatColored,
  autoCloseDuration: const Duration(seconds: 5),
  title: Text(message),
  alignment: Alignment.topRight,
  direction: TextDirection.ltr,
  animationDuration: const Duration(milliseconds: 300),
  // animationBuilder: (context, animation, alignment, child) {
  //   // return FadeTransition(
  //   //   turns: animation,
  //   //   child: child,
  //   // );
  // },
  icon: const Icon(Icons.cancel),
  primaryColor: Colors.red,
  backgroundColor: Colors.white,
  foregroundColor: Colors.black,
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  borderRadius: BorderRadius.circular(12),
  boxShadow: const [
    BoxShadow(
      color: Color(0x07000000),
      blurRadius: 16,
      offset: Offset(0, 16),
      spreadRadius: 0,
    )
  ],
  showProgressBar: true,
  closeButtonShowType: CloseButtonShowType.onHover,
  closeOnClick: false,
  pauseOnHover: true,
  dragToClose: true,
  applyBlurEffect: true,
  callbacks: ToastificationCallbacks(
    onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
    onCloseButtonTap: (toastItem) => print('Toast ${toastItem.id} close button tapped'),
    onAutoCompleteCompleted: (toastItem) => print('Toast ${toastItem.id} auto complete completed'),
    onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
  ),
);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.2),
        elevation: 0,
        title: Image.asset("assets/icons/Logo.png",scale: 2,),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.3),
                width: 1.5,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/icons/Login Page.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: 400,
            margin: EdgeInsets.symmetric(horizontal: 40),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 30),
                Text(
                  "Cine-2024",
                  style: GoogleFonts.poppins(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Username",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: _isUsernameEmpty ? Colors.red : Colors.grey,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                  ),
                ),
                if (_isUsernameEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Please enter the username',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Password",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: _isPasswordEmpty ? Colors.red : Colors.grey,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                if (_isPasswordEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Please enter the password',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  ),
             SizedBox(height: 30),
             
                  // CircularProgressIndicator(),
                  // Container(
                  //   width:20,
                  //   height: 20,
                  //   child: CustomLoader()),
                    // SizedBox(height: 20,),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(84, 108, 255, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      onPressed: () {
                        toastification.show(
  context: context, // optional if you use ToastificationWrapper
  type: ToastificationType.success,
  style: ToastificationStyle.flatColored,
  autoCloseDuration: const Duration(seconds: 5),
  title: Text('Login successful'),
  alignment: Alignment.topRight,
  direction: TextDirection.ltr,
  animationDuration: const Duration(milliseconds: 300),
  // animationBuilder: (context, animation, alignment, child) {
  //   // return FadeTransition(
  //   //   turns: animation,
  //   //   child: child,
  //   // );
  // },
  icon: const Icon(Icons.check),
  primaryColor: Colors.green,
  backgroundColor: Colors.white,
  foregroundColor: Colors.black,
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  borderRadius: BorderRadius.circular(12),
  boxShadow: const [
    BoxShadow(
      color: Color(0x07000000),
      blurRadius: 16,
      offset: Offset(0, 16),
      spreadRadius: 0,
    )
  ],
  showProgressBar: true,
  closeButtonShowType: CloseButtonShowType.onHover,
  closeOnClick: false,
  pauseOnHover: true,
  dragToClose: true,
  applyBlurEffect: true,
  callbacks: ToastificationCallbacks(
    onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
    onCloseButtonTap: (toastItem) => print('Toast ${toastItem.id} close button tapped'),
    onAutoCompleteCompleted: (toastItem) => print('Toast ${toastItem.id} auto complete completed'),
    onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
  ),
);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SideMenuBar(userName: "Vidhi"))); },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                SizedBox(height: 40),
                // if (_errorMessage != null)
                //   Text(
                //     _errorMessage!,
                //     style: TextStyle(color: Colors.red),
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

