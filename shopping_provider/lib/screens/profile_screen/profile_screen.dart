import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_provider/services/firebase/auth/firebase_auth_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuthService().signOut();
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao sair. Tente novamente.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: size.height * 0.4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.lightBlueAccent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: size.width * 0.15,
                      backgroundImage: AssetImage("assets/profile3.jpg"),
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(height: size.height * 0.03),
                    FutureBuilder<String?>(
                      future: FirebaseAuthService().getUserName(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text(
                            "Erro ao carregar nome",
                            style: GoogleFonts.lato(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: size.width * 0.05,
                            ),
                          );
                        } else if (snapshot.hasData && snapshot.data != null) {
                          return Text(
                            snapshot.data!,
                            style: GoogleFonts.lato(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: size.width * 0.05,
                            ),
                          );
                        } else {
                          return Text(
                            "Nome não disponível",
                            style: GoogleFonts.lato(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: size.width * 0.05,
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: size.height * 0.02),
                    FutureBuilder<String?>(
                      future: FirebaseAuthService().getUserEmail(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text(
                            "Erro ao carregar e-mail",
                            style: GoogleFonts.lato(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: size.width * 0.04,
                            ),
                          );
                        } else if (snapshot.hasData && snapshot.data != null) {
                          return Text(
                            snapshot.data!,
                            style: GoogleFonts.lato(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: size.width * 0.04,
                            ),
                          );
                        } else {
                          return Text(
                            "E-mail não disponível",
                            style: GoogleFonts.lato(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: size.width * 0.04,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.04),
                child: Column(
                  children: [
                    Text(
                      "Endereço de entrega",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.05,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "Rua Exemplo, 123, Cidade, Estado",
                      style: GoogleFonts.lato(
                        fontSize: size.width * 0.04,
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Text(
                      "Métodos de Pagamento",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.05,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "Cartão de Crédito: **** **** **** 1234",
                      style: GoogleFonts.lato(
                        fontSize: size.width * 0.04,
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Alterar senha'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.04),
              Container(
                child: ElevatedButton(
                  onPressed: () => _logout(context),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.1,
                      vertical: size.height * 0.015,
                    ),
                    child: Text(
                      'Sair',
                      style: GoogleFonts.lato(
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
