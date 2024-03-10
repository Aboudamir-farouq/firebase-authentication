import 'package:firebase_authentication/screens/login_screen.dart';
import 'package:firebase_authentication/services/firebase_auth_service.dart';
import 'package:firebase_authentication/services/navigation_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: Padding(
          padding: EdgeInsets.only(right: MediaQuery.sizeOf(context).width * 0.15),
          child: const Center(
            child: Text('Home'),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => signOut(context),
        child: const Icon(Icons.logout_outlined, color: Colors.white),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: 7,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ListTile(
                  title: Center(
                    child: Text(
                      'Item $index',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),
                    )
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }

  void signOut(BuildContext context) {
    FirebaseAuthService.signOut();
    NavigationService.navigateTo(context, const LoginScreen());
  }
}