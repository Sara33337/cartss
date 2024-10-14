part of 'carts_cubit.dart';

@immutable
sealed class CartsState {}

final class CartsInitial extends CartsState {}


class CartsLoaded extends CartsState {
  final List<CartModel> Carts;

  CartsLoaded(this.Carts);
}
