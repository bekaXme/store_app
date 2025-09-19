import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/home/home_cubit.dart';
import '../../cubit/home/home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Discover")),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == HomeStatus.failure) {
            return Center(child: Text(state.error ?? "Something went wrong"));
          }
          if (state.status == HomeStatus.success) {
            return ListView(
              children: [
                /// Categories
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Categories",
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      return Container(
                        width: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(category.imageUrl),
                              radius: 35,
                            ),
                            const SizedBox(height: 5),
                            Text(category.name,
                                overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                /// Products
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Products",
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.network(
                              product.imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(product.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ),
                          Text("\$${product.price}"),
                        ],
                      ),
                    );
                  },
                )
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
