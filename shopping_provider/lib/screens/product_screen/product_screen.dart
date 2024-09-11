import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopping_provider/models/product_model.dart';
import 'package:shopping_provider/provider/product_provider.dart';

import '../../provider/cart_provider.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel product;

  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Color selectedColor = Colors.redAccent;
  int selectedSize = 6;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  widget.product.isAvailable
                      ? GestureDetector(
                          onTap: () {
                            // add or remove from favorite
                            productProvider.toggleFavorite(widget.product);
                          },
                          child: Icon(
                            widget.product.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: size.width * 0.07,
                            color: widget.product.isFavorite
                                ? Colors.redAccent
                                : Colors.black,
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    widget.product.image,
                    height: size.height / 3,
                  ),
                ),
                SizedBox(height: size.height * 0.020),
                Text(
                  "Disponível",
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: size.width * 0.04,
                  ),
                ),
                Text(
                  widget.product.name,
                  style: GoogleFonts.poppins(
                    // color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: size.width * 0.07,
                  ),
                ),
                SizedBox(height: size.height * 0.012),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width / 4,
                      height: size.height * 0.04,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Desconto 20%",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: size.height * 0.015,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 23),
                        Text(
                          "4.8",
                          style: GoogleFonts.poppins(
                            fontSize: size.height * 0.037,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          " (232) Avaliações",
                          style: GoogleFonts.poppins(
                            color: Colors.black45,
                            fontSize: size.width * 0.037,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.012),
                Text(
                  "Informação",
                  style: GoogleFonts.poppins(
                    fontSize: size.height * 0.023,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Text(
                  widget.product.desc,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.037,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Cor: ",
                      style: GoogleFonts.poppins(
                        fontSize: size.height * 0.023,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 30,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.product.colors!.length,
                            itemBuilder: (context, index) {
                              Color color = widget.product.colors![index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedColor = color;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: color,
                                    border: Border.all(
                                      color: selectedColor == color
                                          ? Colors.black54
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Tamanho: ",
                      style: GoogleFonts.poppins(
                        fontSize: size.height * 0.023,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 30,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.product.sizes!.length,
                            itemBuilder: (context, index) {
                              int size = widget.product.sizes![index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedSize = size;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[100],
                                    border: Border.all(
                                      color: selectedSize == size
                                          ? Colors.black54
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(size.toString()),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: size.height * 0.08,
          margin: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    "Preço",
                    style: GoogleFonts.poppins(
                      color: Colors.black54,
                      fontSize: size.width * 0.04,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    "\$ ${widget.product.price}",
                    style: GoogleFonts.poppins(
                      fontSize: size.width * 0.055,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              widget.product.isAvailable
                  ? Container(
                      width: size.width / 2,
                      height: size.height * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<CartProvider>()
                              .addToCart(widget.product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(
                                "Item adicionado!",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Add ao Carrinho",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.redAccent,
                          radius: 4,
                        ),
                        SizedBox(width: size.width * 0.020),
                        Text(
                          "Esgotado",
                          style: GoogleFonts.poppins(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * 0.031,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
