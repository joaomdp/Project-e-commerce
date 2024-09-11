import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_provider/screens/main_screen.dart';
import 'package:shopping_provider/services/firebase/auth/firebase_auth_service.dart';
import 'package:shopping_provider/utils/results.dart';
import 'package:shopping_provider/widgets/button.dart';
import 'package:shopping_provider/widgets/text_field.dart';

import '../register_screen/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: StreamBuilder<Results>(
              stream: _auth.resultsLogin,
              builder: (context, snapshot) {
                if (snapshot.data is LoadingResult) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.data is ErrorResult) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      _errorMessage = (snapshot.data as ErrorResult).code;
                    });
                  });
                }

                if (snapshot.data is SuccessResult) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MainScreen()));
                  });
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: height / 2.7,
                      child: Image.asset(
                        "assets/login.png",
                      ),
                    ),
                    if (_errorMessage != null)
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    TextFieldInpute(
                      textEditingController: _emailController,
                      hintText: "Insira seu E-mail",
                      icon: Icons.email,
                    ),
                    TextFieldInpute(
                      textEditingController: _passwordController,
                      hintText: "Insira sua Senha",
                      icon: Icons.lock,
                      obscureText: !_isPasswordVisible,
                      isPass: true,
                      toggleObscureText: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Esqueceu a senha?",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    MyButton(
                      onTab: () {
                        final String email = _emailController.text;
                        final String password = _passwordController.text;
                        _auth.signIn(email, password);
                      },
                      text: "Login",
                    ),
                    SizedBox(
                      height: height / 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Não possui uma conta?",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ),
                            );
                          },
                          child: Text(
                            " Cadastre-se",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
