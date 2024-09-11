import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopping_provider/provider/product_provider.dart';
import 'package:shopping_provider/widgets/category_header.dart';
import 'package:shopping_provider/widgets/product.dart';

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

    final List<ProductModel> favoriteShirts =
    productProvider.shirts.where((product) => product.isFavorite).toList();
    final List<ProductModel> favoritePants =
    productProvider.pants.where((product) => product.isFavorite).toList();
    final List<ProductModel> favoriteShoes =
    productProvider.shoes.where((product) => product.isFavorite).toList();

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
                        Text(
                          "Produtos Favoritos",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * 0.050,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          "Seus Produtos Favoritos",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: size.width * 0.040,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: size.width * 0.060,
                      foregroundImage: AssetImage(
                        "assets/profile3.jpg",
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
                if (favoriteShirts.isNotEmpty)
                  Column(
                    children: [
                      CategoryHeader(
                          title: "Camisetas",
                          count: '${favoriteShirts.length}'),
                      SizedBox(height: size.height * 0.020),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: favoriteShirts
                              .map((product) => Product(product: product))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                if (favoriteShoes.isNotEmpty)
                  Column(
                    children: [
                      CategoryHeader(
                          title: "Tênis",
                          count: '${favoriteShoes.length}'),
                      SizedBox(height: size.height * 0.020),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: favoriteShoes
                              .map((product) => Product(product: product))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                if (favoritePants.isNotEmpty)
                  Column(
                    children: [
                      CategoryHeader(
                          title: "Calças",
                          count: '${favoritePants.length}'),
                      SizedBox(height: size.height * 0.020),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: favoritePants
                              .map((product) => Product(product: product))
                              .toList(),
                        ),
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
