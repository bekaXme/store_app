import 'package:store_app/data/models/home/product_model.dart';

abstract class SavedProductsEvent {}

class ToggleSavedProduct extends SavedProductsEvent {
  final ProductModel product;
  ToggleSavedProduct(this.product);
}

class ClearSavedProducts extends SavedProductsEvent {}
