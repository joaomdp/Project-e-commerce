import 'package:flutter/material.dart';
import 'package:shopping_provider/screens/login_screen/login_screen.dart';
import 'package:shopping_provider/services/firebase/auth/firebase_auth_service.dart';
import 'package:shopping_provider/utils/results.dart';
import 'package:shopping_provider/widgets/button.dart';
import 'package:shopping_provider/widgets/text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
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
              stream: _auth.resultsRegister,
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
                    Navigator.pop(context);
                  });
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: height / 2.8,
                      child: Image.asset(
                        "assets/signup.jpeg",
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
                      textEditingController: _nameController,
                      hintText: "Insira seu nome",
                      icon: Icons.person,
                    ),
                    TextFieldInpute(
                      textEditingController: _emailController,
                      hintText: "Insira seu E-mail",
                      icon: Icons.email,
                    ),
                    TextFieldInpute(
                      textEditingController: _passwordController,
                      hintText: "Insira sua senha",
                      icon: Icons.lock,
                      obscureText: !_isPasswordVisible,
                      isPass: true,
                      toggleObscureText: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    MyButton(
                      onTab: () {
                        final String email = _emailController.text.trim();
                        final String password = _passwordController.text.trim();
                        final String name = _nameController.text.trim();

                        _auth.register(email, password, name).catchError((error) {
                          setState(() {
                            _errorMessage = error.toString();
                          });
                        });
                      },
                      text: "Cadastre-se",
                    ),
                    SizedBox(
                      height: height / 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Já possui uma conta?",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            " Login",
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
