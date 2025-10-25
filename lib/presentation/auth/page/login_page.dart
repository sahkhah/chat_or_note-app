// ignore_for_file: use_build_context_synchronously, duplicate_ignore


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_implementation/presentation/auth/page/signup_page.dart';
import 'package:firebase_implementation/presentation/chat/chat_screen.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email, password;
  bool obscure = true;

  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool emptyEmail = false;
  bool emptyPassword = false;

  bool loading = false;

  final _formKey = GlobalKey<FormState>();

  userLogin() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) {
            return ChatScreen(name: credential.user!.displayName.toString() ,);
          },
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('No user found for that email')));
        setState(() {
          loading = false;
        });
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Wrong password provided by user')),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.code)));
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(top: 45, left: 20.0, right: 20.0),
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
            ),
            child: Text(
              'Hello\nSignIn!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 30.0,
              left: 30.0,
              right: 30.0,
              bottom: 25.0,
            ),
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 4,
            ),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gmail',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25.0,
                        color: Color(0xffb91635),
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          setState(() {
                            emptyEmail = true;
                          });
                          return 'Please enter your gmail';
                        }
                        return null;
                      },
                      controller: mailController,
                      decoration: InputDecoration(
                        hintText: 'Gmail',
                        prefixIcon: Icon(Icons.mail_outlined),
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    Text(
                      'Password',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25.0,
                        color: Color(0xffb91635),
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          setState(() {
                            emptyPassword = true;
                          });
                          return 'Please enter a password';
                        }
                        return null;
                      },
                      controller: passwordController,
                      obscureText: obscure,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.password_outlined),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscure ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const SizedBox(height: 70.0),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xffb91635),
                            Color(0xff621d3c),
                            Color(0xff311937),
                          ],
                        ),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              loading = true;
                            });
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                email = mailController.text;
                                password = passwordController.text;
                              });
                              userLogin();
                            }
                          },
                          child:
                              loading && !(_formKey.currentState!.validate())
                                  ? Center(
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                  : Text(
                                    'SIGN IN',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.0,
                                    ),
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          color: Color(0xff621d3c),
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color(0xff621d3c),
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
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
