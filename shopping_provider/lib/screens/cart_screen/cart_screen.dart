import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shopping_provider/provider/cart_provider.dart';
import 'package:shopping_provider/widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Meu Carrinho",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: context.watch<CartProvider>().shoppingCart.isNotEmpty
                        ? _buildCartItems(context)
                        : _buildEmptyCart(size),
                  ),
                ),
              ),
              if (context.watch<CartProvider>().shoppingCart.isNotEmpty)
                _buildOrderInfo(context, size),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartItems(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Consumer<CartProvider>(
          builder: (context, value, child) {
            return Column(
              children: value.shoppingCart
                  .map((cartItem) => CartItem(cartItem: cartItem))
                  .toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildEmptyCart(Size size) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.25),
          Icon(
            Iconsax.bag,
            size: size.width * 0.20,
            color: Colors.grey,
          ),
          SizedBox(height: size.height * 0.20),
          Text(
            "Seu carrinho está vazio!",
            style: GoogleFonts.poppins(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderInfo(BuildContext context, Size size) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Informações do Pedido",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: size.width * 0.040,
            ),
          ),
          SizedBox(height: size.height * 0.010),
          _buildOrderInfoRow("Sub Total", "\$${context.watch<CartProvider>().cartSubTotal}"),
          SizedBox(height: size.height * 0.010),
          _buildOrderInfoRow("Frete", "\$${context.watch<CartProvider>().shippingCharge}"),
          SizedBox(height: size.height * 0.015),
          _buildOrderInfoRow("Total", "\$${context.watch<CartProvider>().cartTotal}", fontWeight: FontWeight.w500),
          SizedBox(height: size.height * 0.030),
          _buildCheckoutButton(context, size),
        ],
      ),
    );
  }

  Widget _buildOrderInfoRow(String label, String value, {FontWeight fontWeight = FontWeight.normal}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontWeight: fontWeight,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton(BuildContext context, Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.065,
      child: ElevatedButton(
        onPressed: () {},
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
            "Confirmar (\$${context.watch<CartProvider>().cartTotal})",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
