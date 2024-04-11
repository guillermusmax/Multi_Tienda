import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_tienda/controllers/auth_controller.dart';
import 'package:multi_tienda/views/buyers/Landing/landing_screen.dart';
import 'package:multi_tienda/views/buyers/authorization/register_screen.dart';
import 'package:multi_tienda/views/buyers/nav_screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthController _authController = AuthController();

  late String email;
  late String password;
  bool _isLoading = false;
  bool _isObscure = true;

  signInUser() async {
    setState(() {
      _isLoading = true;
    });
    if(_formKey.currentState!.validate()){
      var response = await _authController.LoginUser(email, password);
      BuildContext localContext = context;

      if (response == 'sucess') {
        Future.delayed(Duration.zero, (){
          Navigator.push(localContext,
              MaterialPageRoute(builder: (context){
            return const Mainscreen();
          },));
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Login Sucesfull')));
        }).whenComplete((){
          setState(() {
            _formKey.currentState!.reset();
            _isLoading = false;
          });
        });

      }
      else{
        Future.delayed(Duration.zero, (){
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(response)));
        }).whenComplete((){
          setState(() {
            _isLoading = false;
          });
        });
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Form(
        key: _formKey,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login to your Account',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 23.0,
                                color: Color(0XFF0D12FF),
                                fontWeight: FontWeight.bold)),
                      ),
                      Text(
                        "to explore the world exclusive",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                        )),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Image.asset(
                        'assets/images/Illustration.png',
                        width: 200,
                        height: 200,
                      ),
                      TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter a valid email address';
                          }
                          else{
                            return null;
                          }
                        },
                        onChanged: (value){
                          email = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color(0XFF0D12FF),
                          ),
                          labelText: 'Your Email',
                          hintText: 'user@email.com',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: _isObscure,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter a valid password';
                          }
                          else{
                            return null;
                          }
                        },
                        onChanged: (value){
                          password = value;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0XFF0D12FF),
                          ),
                          suffixIcon: InkWell(
                            onTap: (){
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                              child: Icon(Icons.visibility)
                          ),
                          labelText: 'Your Password',
                          hintText: 'your password',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      GestureDetector(
                        onTap: (){
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context){
                          //       return const Mainscreen();
                          //     },));
                          signInUser();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 70,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF262fde),
                                Color(0xff050957),
                              ]),
                              borderRadius: BorderRadius.circular(10.0)
                          ),

                          child: Center(
                            child: _isLoading
                            ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : Text(
                              'login',
                              style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold),
                            ),

                          ),

                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Need an Account'),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            child: Text(
                              'Register here!',
                              style: GoogleFonts.roboto(
                                color: Color(0xff050957),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return RegisterScreen();
                              }));
                            },
                          ),
                        ],
                      )
                    ],
                  ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
