import 'package:cartapp/bussiness_logic/cubit/carts_cubit.dart';
import 'package:cartapp/components/AddedProducts.dart';
import 'package:cartapp/components/Cart.dart';
import 'package:cartapp/models/CartModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, this.product});
  static String id = "HomePage";
  final CartProducts? product;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Set<CartProducts> addedProducts = {}; 
  late List<CartModel> searchedProducts = [];
  bool isSearching = false;
  final searchTextController = TextEditingController();
  late List<CartModel> allCarts = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartsCubit>(context).fetchCarts();
  }

  void handleProductAddedOrRemoved(CartProducts product) {
    setState(() {
      if (addedProducts.contains(product)) {
        addedProducts.remove(product); 
        product.status = "Add"; 
      } else {
        addedProducts.add(product); 
        product.status = "Remove"; 
      }
    });
  }

  void filterSearch(String searchedChar) {
    if (searchedChar.isEmpty) {
      searchedProducts =
          List.from(allCarts); 
    } else {
      searchedProducts = allCarts
          .map((cart) {
            final filteredProducts = cart.products.where((product) {
              final productTitle = product.productTitle ?? "not found";
              return productTitle
                  .toLowerCase()
                  .startsWith(searchedChar.toLowerCase());
            }).toList();

            
            if (filteredProducts.isNotEmpty) {
              return CartModel(
                cartId: cart.cartId,
                products: filteredProducts, 
              );
            }
            return null;
          })
          .where((cart) => cart != null)
          .cast<CartModel>()
          .toList();
    }

    setState(() {
      isSearching = true; 
    });
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartsCubit, CartsState>(
        builder: (context, state) {
          if (state is CartsInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CartsLoaded) {
            allCarts = state.Carts;

            return Column(
              children: [
                SizedBox(
                  height: 40,
                ),

                Text('Add Products Here'),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  child: TextField(
                    controller: searchTextController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: IconButton(
                            onPressed: () {}, icon: Icon(Icons.search)),
                        suffixIcon: IconButton(
                            onPressed: () {
                              searchTextController.clear();
                              setState(() {
                                isSearching = false;
                              });
                            },
                            icon: Icon(Icons.clear))),
                    onChanged: (searchedChar) {
                      filterSearch(searchedChar);
                    },
                  ),
                ),
              
                if (addedProducts.isNotEmpty)
                  CustomAddedProducts(
                  addedProducts: addedProducts, 
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: searchTextController.text.isEmpty
                        ? allCarts.length
                        : searchedProducts.length,
                    itemBuilder: (context, index) {
                      return CartList(
                        cart: searchTextController.text.isEmpty
                            ? allCarts[index]
                            : searchedProducts[index],
                        onProductAddedOrRemoved: handleProductAddedOrRemoved,
                        expanded: searchTextController.text.isEmpty ? false : true,
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Text("Failed to load carts"));
          }
        },
      ),
    );
  }
}
