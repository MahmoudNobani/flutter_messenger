import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger/components/my_button.dart';
import 'package:messenger/components/my_text_field.dart';
import 'package:messenger/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailCont = TextEditingController();
  final passCont = TextEditingController();

  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.singInWithEmailAndPassword(
          emailCont.text, passCont.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25,
                ),
                //logo
                Icon(
                  Icons.message,
                  size: 100,
                  color: Colors.grey[800],
                ),
                SizedBox(
                  height: 50,
                ),
                //welcome back msg
                const Text(
                  "Welcome back sir, you\'ve been missed!",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 25,
                ),
                //email textfield
                MyTextField(
                    controller: emailCont,
                    hintText: 'Email',
                    obscureText: false),
                SizedBox(
                  height: 10,
                ),
                //password textfield
                MyTextField(
                    controller: passCont,
                    hintText: 'Password',
                    obscureText: true),
                SizedBox(
                  height: 25,
                ),
                //sign in
                MyButton(
                  text: 'Sign in',
                  onTap: signIn,
                ),
                SizedBox(
                  height: 50,
                ),
                //register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member?'),
                    SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Register now',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
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
