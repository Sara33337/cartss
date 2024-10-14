import 'package:cartapp/models/CartModel.dart';
import 'package:flutter/material.dart';

class CartList extends StatefulWidget {
  final CartModel cart;
  final Function(CartProducts) onProductAddedOrRemoved;
  final bool expanded;

  CartList({required this.cart,
   required this.onProductAddedOrRemoved , 
   required this.expanded});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 218, 215, 215),
        ),
        child: ExpansionTile(
          title: Text('Cart ${widget.cart.cartId}'),
          trailing: Icon(Icons.arrow_drop_down),
          initiallyExpanded: widget.expanded,
          children: [
            Column(
              children: widget.cart.products.map((product) {
              
                return ListTile(
                  title: Text('${product.productTitle}'),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        product.thumbnail,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.error); 
                        },
                      ),
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      widget.onProductAddedOrRemoved(product);
                    },
                    child: Container(
                      width: 80,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 185, 163, 163),
                      ),
                      child: Center(
                        child: Text(
                          product.status,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
