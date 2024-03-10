import 'package:firebase_authentication/screens/home_screen.dart';
import 'package:firebase_authentication/screens/sign_in_screen.dart';
import 'package:firebase_authentication/services/firebase_auth_service.dart';
import 'package:firebase_authentication/services/navigation_service.dart';
import 'package:firebase_authentication/widgets/custom_button.dart';
import 'package:firebase_authentication/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: Padding(
          padding: EdgeInsets.only(right: MediaQuery.sizeOf(context).width * 0.15),
          child: const Center(
            child: Text('Login'),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                CustomTextField(
                  inputController: email,
                  hintText: 'Email',
                  suffixIcon: Icons.email_outlined,
                ),
                CustomTextField(
                  inputController: password,
                  hintText: 'Password',
                  isPassword: true,
                  suffixIcon: Icons.password_outlined,
                ),
                CustomButton(
                  isLoading: isLoading,
                  textButton: 'Login',
                  onPressed: login,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an accout?',
                        style: TextStyle(
                          fontSize: 16
                        ),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap:() => NavigationService.navigateTo(context, const SignInScreen()),
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      FirebaseAuthService.signInWithEmailAndPassword(
        email: email.text,
        password: password.text
      ).then((user) {
        if (user == null) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: const Text('Error', style: TextStyle(fontSize: 20)),
                content: const Text('The email address or password you entered is incorrect. Please try again.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                  ),
                ],
              );
            },
          );
        } else {
          if (user.emailVerified) {
            NavigationService.navigateTo(context, const HomeScreen());
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: const Text('Info', style: TextStyle(fontSize: 20)),
                  content: const Text('a verification email has been sent to you, please validate your email to be able to log in.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                  ],
                );
              },
            );
          }
        }
        setState(() {
          isLoading = false;
        });
      });
    });
  }
}