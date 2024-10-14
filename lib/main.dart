import 'package:cartapp/bussiness_logic/cubit/carts_cubit.dart';
import 'package:cartapp/screens/homepage.dart';
import 'package:cartapp/services/getCarts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import this for BlocProvider and BlocBuilder

void main() {
  runApp(const CartApp());
}

class CartApp extends StatelessWidget {
  const CartApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartsCubit(GetAllCarts()),  // Pass the GetAllCarts service
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          HomePage.id: (context) => HomePage(),
        },
        initialRoute: HomePage.id,
      ),
    );
  }
}
