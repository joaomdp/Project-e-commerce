import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopping_provider/provider/product_provider.dart';

import '../../models/product_model.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    final List<ProductModel> allProducts = [
      ...productProvider.shirts,
      ...productProvider.pants,
      ...productProvider.shoes,
    ];

    final List<ProductModel> favoriteProducts =
    allProducts.where((product) => product.isFavorite).toList();

    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Favorite Products",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.050,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.020),
                SizedBox(
                  width: size.width,
                  child: TextFormField(
                    decoration: InputDecoration(
                      focusColor: Colors.black38,
                      isCollapsed: false,
                      hintText: "Search products",
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
                SizedBox(height: size.height * 0.030),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: favoriteProducts.length,
                  itemBuilder: (context, index) {
                    final product = favoriteProducts[index];
                    return Container(
                      width: double.infinity,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white54,
                        boxShadow: [BoxShadow(
                            color: Colors.white60,
                            spreadRadius: 0.5,
                            offset: Offset(5,5)),
                        ],
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            product.image,
                            fit: BoxFit.contain,
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(height: size.height * 0.020,),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              product.name,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: size.width * 0.033,
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$ ${product.price}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: size.width * 0.040,
                                  ),
                                ),
                                GestureDetector()
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
