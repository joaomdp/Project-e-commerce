import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  final List<ProductModel> _shirts = [
    ProductModel(
      name: "Camisa Preta",
      price: 50,
      image: 'assets/black t-shirt.png',
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      sizes: [5, 6, 7, 8, 9],
      colors: [
        Colors.redAccent,
        Colors.greenAccent,
        Colors.amber,
        Colors.indigo,
        Colors.black,
      ],
      isAvailable: true,
    ),
    ProductModel(
      name: "Camisa Vermelha",
      price: 60,
      image: "assets/red t-shirt.png",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      sizes: [5, 6, 7, 8, 9],
      colors: [
        Colors.redAccent,
        Colors.greenAccent,
        Colors.amber,
        Colors.indigo,
        Colors.black,
      ],
      isAvailable: false,
    ),
  ];

  final List<ProductModel> _pants = [
    ProductModel(
      name: "Calça Azul",
      price: 79,
      image: "assets/cotton pant 1.png",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      sizes: [5, 6, 7, 8, 9],
      colors: [
        Colors.redAccent,
        Colors.greenAccent,
        Colors.amber,
        Colors.indigo,
        Colors.black,
      ],
      isAvailable: true,
    ),
    ProductModel(
      name: "Calça Marrom",
      price: 80,
      image: "assets/grey cotton pant 2.png",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      sizes: [5, 6, 7, 8, 9],
      colors: [
        Colors.redAccent,
        Colors.greenAccent,
        Colors.amber,
        Colors.indigo,
        Colors.black,
      ],
      isAvailable: true,
    )
  ];

  final List<ProductModel> _shoes = [
    ProductModel(
      name: "Tênis Verde",
      price: 120,
      image: "assets/shoe 1.png",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      sizes: [5, 6, 7, 8, 9],
      colors: [
        Colors.redAccent,
        Colors.greenAccent,
        Colors.amber,
        Colors.indigo,
        Colors.black,
      ],
      isAvailable: true,
    ),
    ProductModel(
      name: "Tênis Roxo",
      price: 200,
      image: "assets/shoe 2.png",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      sizes: [5, 6, 7, 8, 9],
      colors: [
        Colors.redAccent,
        Colors.greenAccent,
        Colors.amber,
        Colors.indigo,
        Colors.black,
      ],
      isAvailable: true,
    )
  ];

  void toggleFavorite(ProductModel product) {
    product.isFavorite = !product.isFavorite;
    notifyListeners();
  }

  List<ProductModel> get shirts => _shirts;
  List<ProductModel> get pants => _pants;
  List<ProductModel> get shoes => _shoes;
}
