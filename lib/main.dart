
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messenger/firebase_options.dart';
import 'package:messenger/pages/login_page.dart';
import 'package:messenger/services/auth/auth_gate.dart';
import 'package:messenger/services/auth/auth_service.dart';
import 'package:messenger/services/auth/login_or_register.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (context) => AuthService(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: AuthGate());
  }
}
