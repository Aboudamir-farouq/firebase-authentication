import 'package:firebase_authentication/screens/login_screen.dart';
import 'package:firebase_authentication/services/firebase_auth_service.dart';
import 'package:firebase_authentication/services/navigation_service.dart';
import 'package:firebase_authentication/widgets/custom_button.dart';
import 'package:firebase_authentication/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isLoading = false;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => NavigationService.goBack(context),
          icon: const Icon(Icons.arrow_back_ios)
        ),
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: MediaQuery.sizeOf(context).width * 0.15),
            child: const Text('Sign in'),
          )
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
                    'Sign in',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                CustomTextField(
                  inputController: name,
                  hintText: 'Name',
                  suffixIcon: Icons.person_2_outlined,
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
                  textButton: 'Sign in',
                  onPressed: signIn,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Alredy have an accout ?',
                        style: TextStyle(
                          fontSize: 16
                        ),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap:() => NavigationService.goBack(context),
                        child: const Text(
                          'Login',
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

  void signIn() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      FirebaseAuthService.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text
      ).then((user) => {
        if (user == null) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: const Text('Error', style: TextStyle(fontSize: 20)),
                content: const Text('An error has occurre, the email can be alredy existe please try again.'),
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
          )
        } else {
          NavigationService.navigateTo(context, const LoginScreen())
        }
      });
      setState(() {
        isLoading = false;
      });
    });
  }
}