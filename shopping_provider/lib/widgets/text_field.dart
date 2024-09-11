import 'package:flutter/material.dart';

class TextFieldInpute extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final Function()? toggleObscureText;

  const TextFieldInpute({
    super.key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.toggleObscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        obscureText: obscureText,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.black45,
            fontSize: 18,
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.black45,
          ),
          suffixIcon: isPass
              ? IconButton(
            icon: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
              color: Colors.black45,
            ),
            onPressed: toggleObscureText,
          )
              : null,
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          border: InputBorder.none,
          filled: true,
          fillColor: Color(0xFFedf0f8),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
