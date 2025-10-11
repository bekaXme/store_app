import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/features/common/bottom_nav_widget.dart';
import '../../savedProducts/bloc/saved_product_bloc.dart';
import '../../savedProducts/bloc/saved_products_event.dart';
import '../../savedProducts/bloc/saved_products_state.dart';

class SavedProductsPage extends StatelessWidget {
  const SavedProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Products'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.go('/notifications');
            },
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: BlocBuilder<SavedProductsBloc, SavedProductsState>(
        builder: (context, state) {
          if (state.status == SavedProductsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == SavedProductsStatus.failure) {
            return Center(child: Text(state.errorMessage ?? 'Error'));
          }
          if (state.savedProducts.isEmpty) {
            return Center(
              child: Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/Heart.svg',
                    width: 64,
                    height: 64,
                  ),
                  Text(
                    'No Saved Items!',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 252.w,
                    height: 44.h,
                    child: Text(
                      maxLines: 2,
                      'You don’t have any saved items. Go to home and add some.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.65,
            ),
            itemCount: state.savedProducts.length,
            itemBuilder: (context, index) {
              final product = state.savedProducts[index];
              return GestureDetector(
                onTap: () => context.go('/product/${product.id}'),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Image.network(
                                product.image,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  // 🧠 Toggle save/unsave
                                  context.read<SavedProductsBloc>().add(
                                    ToggleSaveProduct(product.id),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "\$${product.price}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 2),
    );
  }
}
