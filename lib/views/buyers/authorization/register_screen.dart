import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_tienda/controllers/auth_controller.dart';
import 'package:multi_tienda/views/buyers/authorization/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthController _authController = AuthController();

  late String email;
  late String fullName;
  late String password;
  bool _isObscure = true;
  
  registerNewUser() async {
    if(_formKey.currentState!.validate()){
      BuildContext localContext = context;
      String response = await _authController.registerUser(email, fullName, password);

     if (response == 'Data Saved') {
       Future.delayed(Duration.zero, (){
       Navigator.push(localContext, MaterialPageRoute(builder: (context){
         return LoginScreen();
       },));
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Account Created')));
       });

     }
     else{
       Future.delayed(Duration.zero, (){
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response)));
       });
     }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Register your Account',
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 23.0,
                          color: Color(0XFF0D12FF),
                            fontWeight: FontWeight.bold
                        )),
                  ),
                  Text(
                    "to explore the world exclusive",
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CircleAvatar(
                    radius: 80,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: AssetImage('assets/icons/user.png'),
                  ),
                  SizedBox(
                    height: 15,
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
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter your user';
                      }
                      else{
                        return null;
                      }
                    },
                    onChanged: (value){
                      fullName = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color(0XFF0D12FF),
                      ),
                      labelText: 'Your User',
                      hintText: 'your user',
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
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter your password';
                      }
                      else{
                        return null;
                      }
                    },
                    onChanged: (value){
                      password = value;
                    },
                    obscureText: true,
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
                  InkWell(
                    onTap: () {
                      registerNewUser();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xFF262fde),
                            Color(0xff050957),
                          ]),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Center(
                        child: Text(
                          'Register',
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
                      Text('Already got a account?'),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        child: Text ('Go to login!',
                          style: GoogleFonts.roboto(
                            color: Color(0xff050957),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return LoginScreen();
                              } )
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        ]
      ),
    );
  }
}
