import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopping_provider/provider/product_provider.dart';
import 'package:shopping_provider/widgets/category_header.dart';
import 'package:shopping_provider/services/firebase/auth/firebase_auth_service.dart';

import '../../widgets/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<String?> _userNameFuture;

  @override
  void initState() {
    super.initState();
    _userNameFuture = FirebaseAuthService().getUserName();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.005),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<String?>(
                          future: _userNameFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text(
                                "E-Shop", // Use fallback text if name retrieval fails
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: size.width * 0.050,
                                  letterSpacing: 0.5,
                                ),
                              );
                            } else if (snapshot.hasData && snapshot.data != null) {
                              return Text(
                                "Bem-Vindo, ${snapshot.data}",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: size.width * 0.050,
                                  letterSpacing: 0.5,
                                ),
                              );
                            } else {
                              return Text(
                                "E-Shop", // Use fallback text if name is null
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: size.width * 0.050,
                                  letterSpacing: 0.5,
                                ),
                              );
                            }
                          },
                        ),
                        Text(
                          "Seus produtos favoritos estão aqui",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: size.width * 0.040,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/profile');
                      },
                      child: CircleAvatar(
                        radius: size.width * 0.060,
                        foregroundImage: AssetImage(
                          "assets/profile3.jpg",
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(height: size.height * 0.025),
                SizedBox(
                  width: size.width,
                  child: TextFormField(
                    decoration: InputDecoration(
                      focusColor: Colors.black38,
                      isCollapsed: false,
                      hintText: "Procure",
                      prefixIcon: Icon(Icons.search),
                      hintStyle: GoogleFonts.poppins(
                        fontSize: size.width * 0.040,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.01,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.black26, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.black26, width: 1),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.025),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/cover.jpg',
                    height: size.height * 0.2,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: size.height * 0.030),
                Column(
                  children: [
                    CategoryHeader(
                        title: "Camisas",
                        count:
                        '${Provider.of<ProductProvider>(context).shirts.length}'
                    ),
                    SizedBox(height: size.height * 0.020),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Consumer<ProductProvider>(
                          builder: (context, value, child) {
                            return Row(
                              children: value.shirts
                                  .map((product) => Product(product: product))
                                  .toList(),
                            );
                          }),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.020),
                Column(
                  children: [
                    CategoryHeader(
                        title: "Tênis",
                        count:
                        '${Provider.of<ProductProvider>(context).shoes.length}'),
                    SizedBox(height: size.height * 0.020),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Consumer<ProductProvider>(
                          builder: (context, value, child) {
                            return Row(
                              children: value.shoes
                                  .map((product) => Product(product: product))
                                  .toList(),
                            );
                          }),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.020),
                Column(
                  children: [
                    CategoryHeader(
                        title: "Calças",
                        count:
                        '${Provider.of<ProductProvider>(context).pants.length}'),
                    SizedBox(height: size.height * 0.020),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Consumer<ProductProvider>(
                          builder: (context, value, child) {
                            return Row(
                              children: value.pants
                                  .map((product) => Product(product: product))
                                  .toList(),
                            );
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
