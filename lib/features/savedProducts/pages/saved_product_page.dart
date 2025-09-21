import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/saved_product_cubit.dart';
import '../bloc/saved_products_state.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Saved Products")),
      body: BlocBuilder<SavedCubit, SavedState>(
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == Status.error) {
            return Center(child: Text(state.errorSavedMessage ?? "Error"));
          }
          if (state.savedProducts.isEmpty) {
            return const Center(child: Text("No saved products yet"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: state.savedProducts.length,
            itemBuilder: (context, index) {
              final product = state.savedProducts[index];
              return ListTile(
                leading: Image.network(product.image, width: 50, fit: BoxFit.cover),
                title: Text(product.title),
                subtitle: Text("\$${product.price}"),
              );
            },
          );
        },
      ),
    );
  }
}
