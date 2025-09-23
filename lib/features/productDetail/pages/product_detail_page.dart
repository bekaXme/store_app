import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/features/savedProducts/bloc/saved_products_state.dart';
import '../managers/product_detail_bloc.dart';
import '../managers/product_detail_state.dart';

class ProductDetailPage extends StatelessWidget {
  final int productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      context.read<ProductDetailBloc>()..add(GetProductId(id: productId)),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.go('/home');
            },
            icon: Icon(Icons.arrow_back, size: 24.sp),
          ),
          title: Text(
            "Details",
            style: TextStyle(fontSize: 18.sp),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                context.go('/notifications');
              },
              icon: Icon(Icons.notifications_outlined, size: 24.sp),
            ),
          ],
        ),
        body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            if (state.productStatus == Status.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.errorProduct != null) {
              return Center(child: Text(state.errorProduct!));
            }
            if (state.product == null) {
              return const Center(child: Text("No product found"));
            }

            final product = state.product!;

            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 341.w,
                    height: 368.h,
                    margin: EdgeInsets.symmetric(vertical: 20.h),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.network(
                            product.productImages.isNotEmpty
                                ? product.productImages.first
                                : "https://via.placeholder.com/300",
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        // ❤️ Favorite Button
                        Positioned(
                          right: 8.w,
                          top: 8.h,
                          child: StatefulBuilder(
                            builder: (context, setState) {
                              bool isFavorite = false;
                              return Container(
                                width: 40.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10.r,
                                      spreadRadius: 2.r,
                                      offset: Offset(0, 5.h),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isFavorite = !isFavorite;
                                    });
                                  },
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFavorite ? Colors.red : Colors.black,
                                    size: 22.sp,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),

                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 20.sp),
                        SizedBox(width: 4.w),
                        Text(
                          "${product.rating.toStringAsFixed(1)}/5",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          "(${product.reviewsCount} reviews)",
                          style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Description
                  Text(
                    product.description,
                    style: TextStyle(color: Colors.black87, height: 1.4, fontSize: 14.sp),
                  ),
                  SizedBox(height: 20.h),

                  Text(
                    "Choose size",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                  SizedBox(height: 8.h),
                  Wrap(
                    spacing: 10.w,
                    children: product.productSizes
                        .map(
                          (size) => ChoiceChip(
                        label: Text(size, style: TextStyle(fontSize: 14.sp)),
                        selected: false,
                      ),
                    )
                        .toList(),
                  ),

                  SizedBox(height: 24.h),

                  Divider(
                    color: Colors.black,
                    thickness: 1.h,
                    height: 1.h,
                  ),

                  Row(
                    children: [
                      Text(
                        "\$${product.price.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton.icon(
                          onPressed: () {
                          },
                          icon: Icon(Icons.shopping_cart_outlined, size: 20.sp),
                          label: Text("Add to Cart", style: TextStyle(fontSize: 16.sp)),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
