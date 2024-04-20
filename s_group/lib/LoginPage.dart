// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:s_group/Signup.dart';
// import 'package:s_group/homescreen.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _isIncorrect = false;

// void _login() async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: _emailController.text,
//         password: _passwordController.text,
//       );
//       // Navigate to HomeScreen after successful login
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => HomeScreen()),
//       );
//     } catch (e) {
//       // Handle login errors here
//       print("Error logging in: $e");
//       setState(() {
//         _isIncorrect = true;
//       });
//     }
//   }

//   void _navigateToSignup() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => SignupPage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Color(0xFF274060),
//                   Color(0xFFFFFFFF), // Lighter shade of the brand color
//                 ],
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.topRight,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 child: Image.asset("assets/3.png",color: Colors.white,height: 120,width: 120,),
//               ),
//             ),
//           ),
//           Center(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.symmetric(horizontal: 20.0),
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   maxWidth: 400, // Set maximum width for content
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Image.asset(
//                       "assets/1.png",
//                       height: 200,
//                       width: 100,
//                     ),
//                     SizedBox(height: 30),
//                     AnimatedContainer(
//                       duration: Duration(milliseconds: 300),
//                       curve: Curves.easeInOut,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5.0),
//                         color: _isIncorrect
//                             ? Colors.red.withOpacity(0.3)
//                             : Colors.white.withOpacity(0.3),
//                       ),
//                       child: TextFormField(
//                         controller: _emailController,
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: InputDecoration(
//                           labelText: 'Email',
//                           labelStyle: TextStyle(color: Colors.black),
//                           prefixIcon: Icon(Icons.email, color: Colors.black),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5.0),
//                             borderSide: BorderSide.none,
//                           ),
//                           contentPadding:
//                               EdgeInsets.symmetric(vertical: 16, horizontal: 20),
//                         ),
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     AnimatedContainer(
//                       duration: Duration(milliseconds: 300),
//                       curve: Curves.easeInOut,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5.0),
//                         color: _isIncorrect
//                             ? Colors.red.withOpacity(0.3)
//                             : Colors.white.withOpacity(0.3),
//                       ),
//                       child: TextFormField(
//                         controller: _passwordController,obscureText: true,
//                         // obscureText: true,
//                         decoration: InputDecoration(
//                           labelText: 'Password',
//                           labelStyle: TextStyle(color: Colors.black),
//                           prefixIcon: Icon(Icons.lock, color: Colors.black),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5.0),
//                             borderSide: BorderSide.none,
//                           ),
//                           contentPadding:
//                               EdgeInsets.symmetric(vertical: 16, horizontal: 20),
//                         ),
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: _login,
//                       child: Text(
//                         'Login',
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
//                       ),
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                           (Set<MaterialState> states) {
//                             return Theme.of(context).primaryColor;
//                           },
//                         ),
//                         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5.0),
//                             side: BorderSide.none,
//                           ),
//                         ),
//                         padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//                           EdgeInsets.symmetric(vertical: 16),
//                         ),
//                         elevation: MaterialStateProperty.all<double>(5),
//                         shadowColor: MaterialStateProperty.all<Color>(
//                           Colors.black.withOpacity(0.3),
//                         ),
//                         overlayColor: MaterialStateProperty.all<Color>(
//                           Colors.transparent,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 10), // Added spacing between Login and Signup buttons
//                     ElevatedButton(
//                       onPressed: _navigateToSignup,
//                       child: Text(
//                         'Sign Up',
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
//                       ),
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                           (Set<MaterialState> states) {
//                             return Theme.of(context).primaryColor;
//                           },
//                         ),
//                         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5.0),
//                             side: BorderSide.none,
//                           ),
//                         ),
//                         padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//                           EdgeInsets.symmetric(vertical: 16),
//                         ),
//                         elevation: MaterialStateProperty.all<double>(5),
//                         shadowColor: MaterialStateProperty.all<Color>(
//                           Colors.black.withOpacity(0.3),
//                         ),
//                         overlayColor: MaterialStateProperty.all<Color>(
//                           Colors.transparent,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:s_group/Signup.dart';
import 'package:s_group/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isIncorrect = false;

  @override
  void initState() {
    super.initState();
    // Check if the user is already logged in
    checkLoggedIn();
  }

  void checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    if (email != null && password != null) {
      // User is already logged in, navigate to HomeScreen
      _login(email, password);
    }
  }

  void _login(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Save email and password to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);
      prefs.setString('password', password);
      // Navigate to HomeScreen after successful login
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      // Handle login errors here
      print("Error logging in: $e");
      setState(() {
        _isIncorrect = true;
      });
    }
  }

  void _navigateToSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF274060),
                  Color(0xFFFFFFFF), // Lighter shade of the brand color
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Image.asset(
                  "assets/3.png",
                  color: Colors.white,
                  height: 120,
                  width: 120,
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 400, // Set maximum width for content
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      "assets/1.png",
                      height: 200,
                      width: 100,
                    ),
                    SizedBox(height: 30),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: _isIncorrect
                            ? Colors.red.withOpacity(0.3)
                            : Colors.white.withOpacity(0.3),
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon:
                              Icon(Icons.email, color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 20),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: _isIncorrect
                            ? Colors.red.withOpacity(0.3)
                            : Colors.white.withOpacity(0.3),
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        // obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(Icons.lock, color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _login(
                            _emailController.text, _passwordController.text);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Theme.of(context).primaryColor;
                          },
                        ),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide.none,
                          ),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(vertical: 16),
                        ),
                        elevation: MaterialStateProperty.all<double>(5),
                        shadowColor:
                            MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.3)),
                        overlayColor: MaterialStateProperty.all<Color>(
                          Colors.transparent,
                        ),
                      ),
                    ),
                    SizedBox(height: 10), // Added spacing between Login and Signup buttons
                    ElevatedButton(
                      onPressed: _navigateToSignup,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Theme.of(context).primaryColor;
                          },
                        ),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide.none,
                          ),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(vertical: 16),
                        ),
                        elevation: MaterialStateProperty.all<double>(5),
                        shadowColor:
                            MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.3)),
                        overlayColor: MaterialStateProperty.all<Color>(
                          Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
