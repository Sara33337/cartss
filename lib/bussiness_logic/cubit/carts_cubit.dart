import 'package:bloc/bloc.dart';
import 'package:cartapp/models/CartModel.dart';
import 'package:cartapp/services/getCarts.dart';
import 'package:meta/meta.dart';

part 'carts_state.dart';

class CartsCubit extends Cubit<CartsState> {
  final GetAllCarts cartService;
  
  CartsCubit(this.cartService) : super(CartsInitial());

  void fetchCarts() {
    cartService.getCarts().then((carts) {
      emit(CartsLoaded(carts));  
    }).catchError((error) {
    
      print("Error fetching carts: $error");
    });
  }
}

