import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_provider/firebase_options.dart';
import 'package:shopping_provider/models/user_model.dart';
import 'package:shopping_provider/provider/cart_provider.dart';
import 'package:shopping_provider/provider/product_provider.dart';
import 'package:shopping_provider/screens/login_screen/login_screen.dart';
import 'package:shopping_provider/services/firebase/auth/firebase_auth_service.dart';
import 'package:shopping_provider/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> ProductProvider()),
      ChangeNotifierProvider(create: (_)=> CartProvider()),
    ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Shopping App",
      theme: Themes.light,
      themeMode: ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (context) => InitializeApp(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}



class InitializeApp extends StatefulWidget {

  InitializeApp({super.key});

  @override
  State<InitializeApp> createState() => _InitializeAppState();
}

class _InitializeAppState extends State<InitializeApp> {
  FirebaseAuthService _auth = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
        stream: _auth.user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return LoginScreen();
        }
    );
  }
}
