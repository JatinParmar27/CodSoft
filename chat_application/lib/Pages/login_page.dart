// ignore_for_file: use_build_context_synchronously

import 'package:chat_application/Components/my_text_field.dart';
import 'package:chat_application/Services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final void Function()? onTap;
  const Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

// Sign in User function
Future<dynamic> _signIn() async {
  final authService = Provider.of<AuthService>(context, listen:false);

  try {
    await authService.signInWithEmailandPassword(emailController.text, passwordController.text);
  } catch (e) {
    // print('error in sign in ');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()),),);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      // appBar: AppBar(title: const Text("Chat Applilcation"),),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Icon(
                  Icons.login_rounded,
                  size: 44,
                ),
                const SizedBox(
                  height: 23,
                ),
                const Text(
                  'Login to your Account',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 23,
                ),
                MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false),
                const SizedBox(
                  height: 23,
                ),
                MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true),
                const SizedBox(
                  height: 23,
                ),
                // MyButton(onTap: (){_signIn();}, text: 'Sign In'),
                ElevatedButton(onPressed: (){_signIn();}, style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.amber)), child: const Text("Sign In"),),
                const SizedBox(
                  height: 50,
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't Have Account?", style: TextStyle(fontSize: 18),),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register Now', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


