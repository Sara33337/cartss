import 'package:cartapp/models/CartModel.dart';
import 'package:flutter/material.dart';

class CustomAddedProducts extends StatefulWidget {
  const CustomAddedProducts(
      {super.key, required this.addedProducts});

  final Set<CartProducts> addedProducts;


  @override
  State<CustomAddedProducts> createState() => _CustomAddedProductsState();
}

class _CustomAddedProductsState extends State<CustomAddedProducts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.addedProducts.length,
        itemBuilder: (context, index) {
          return  Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          widget.addedProducts.elementAt(index).thumbnail,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Text("${widget.addedProducts.elementAt(index).productTitle}"),
                
              ],
            ),
          );
        },
      ),
    );
  }
}
