import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/my_button.dart';
import '../components/my_text_field.dart';
import '../services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailCont = TextEditingController();
  final passCont = TextEditingController();
  final confirmPassCont = TextEditingController();

  void signUp() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    if (confirmPassCont.text != passCont.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Password dont match')));
      return;
    }

    try {
      await authService.singUpWithEmailAndPassword(
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
                  "Lets create an account for you",
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
                  height: 10,
                ),
                //confirm password
                MyTextField(
                    controller: confirmPassCont,
                    hintText: 'Confirm Password',
                    obscureText: true),
                SizedBox(
                  height: 25,
                ),
                //sign in
                MyButton(
                  text: 'Sign up',
                  onTap: signUp,
                ),
                //SizedBox(height: 50,),
                //register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already a member?'),
                    SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Login now',
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
