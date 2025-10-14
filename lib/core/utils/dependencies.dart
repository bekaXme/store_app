import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:store_app/core/interceptor/auth_interceptor.dart';
import 'package:store_app/core/services/client.dart';
import 'package:store_app/data/repositories/address/address_repository.dart';
import 'package:store_app/data/repositories/cart/cart_repository.dart';
import 'package:store_app/data/repositories/me/me_repository.dart';
import 'package:store_app/data/repositories/productItem/product_item_repository.dart';
import 'package:store_app/data/repositories/search/search_repository.dart';
import 'package:store_app/features/adress/managers/address_bloc.dart';
import 'package:store_app/features/cart/managers/cart_bloc.dart';
import 'package:store_app/features/me/managers/me_bloc.dart';
import 'package:store_app/features/notifications/managers/notifications_cubit.dart';
import 'package:store_app/data/repositories/notifications/notifications_repository.dart';
import 'package:store_app/features/home/cubit/home_cubit.dart';
import 'package:store_app/data/repositories/auth/auth_repository.dart';
import 'package:store_app/data/repositories/home/home_repository.dart';
import 'package:store_app/features/auth/managers/authlogin_view_model.dart';
import 'package:store_app/features/search_items/managers/search_bloc.dart';
import 'package:store_app/data/repositories/savedProducts/saved_products_repository.dart';
import 'package:store_app/features/productDetail/managers/product_detail_bloc.dart';
import 'package:store_app/features/savedProducts/bloc/saved_product_bloc.dart';
import 'package:store_app/data/repositories/payment/payment_repository.dart';
import 'package:store_app/features/card/managers/card_bloc.dart';

import '../../data/repositories/orders/order_repository.dart';
import '../../features/orders/managers/order_bloc.dart';

final List<SingleChildWidget> dependencies = [
  Provider(create: (context) => const FlutterSecureStorage()),

  Provider(create: (context) => AuthInterceptor(secureStorage: context.read())),

  ProxyProvider<AuthInterceptor, ApiClient>(
    update: (_, interceptor, __) => ApiClient(interceptor: interceptor),
  ),

  Provider<AuthRepository>(
    create: (context) => AuthRepository(context.read<ApiClient>()),
  ),

  ChangeNotifierProvider(
    create: (context) => AuthVM(context.read<AuthRepository>()),
  ),

  Provider<HomeRepository>(
    create: (context) => HomeRepository(client: context.read<ApiClient>()),
  ),

  Provider<NotificationRepository>(
    create: (context) => NotificationRepository(context.read<ApiClient>()),
  ),

  Provider<SavedProductsRepository>(
    create: (context) =>
        SavedProductsRepository(apiClient: context.read<ApiClient>()),
  ),

  Provider<ProductDetailRepository>(
    create: (context) =>
        ProductDetailRepository(apiClient: context.read<ApiClient>()),
  ),

  Provider<CartRepository>(
    create: (context) => CartRepository(client: context.read<ApiClient>()),
  ),

  Provider<OrderRepository>(
    create: (context) => OrderRepository(client: context.read<ApiClient>()),
  ),

  BlocProvider(
    create: (context) => CartBloc(
      context.read<CartRepository>(),
      context.read<OrderRepository>(),
    ),
  ),

  RepositoryProvider(create: (context) => OrderRepository(client: context.read<ApiClient>())),

  BlocProvider(
    create: (context) => OrderBloc(repository: context.read<OrderRepository>()),
  ),

  RepositoryProvider(
    create: (context) =>
        SavedProductsRepository(apiClient: context.read<ApiClient>()),
  ),

  BlocProvider(
    create: (context) =>
        SavedProductsBloc(repository: context.read<SavedProductsRepository>()),
  ),

  RepositoryProvider(
    create: (context) => SearchRepository(apiClient: context.read<ApiClient>()),
  ),

  RepositoryProvider(
    create: (context) => MyInfoRepository(client: context.read<ApiClient>()),
  ),

  BlocProvider(
    create: (context) => MeBloc(repository: context.read<MyInfoRepository>()),
  ),

  BlocProvider(
    create: (context) =>
        SearchBloc(repository: context.read<SearchRepository>()),
  ),

  BlocProvider<ProductDetailBloc>(
    create: (context) =>
        ProductDetailBloc(repository: context.read<ProductDetailRepository>()),
  ),

  BlocProvider<HomeCubit>(
    create: (context) => HomeCubit(context.read<HomeRepository>())..loadData(),
  ),

  BlocProvider<NotificationsCubit>(
    create: (context) =>
        NotificationsCubit(context.read<NotificationRepository>())..loadData(),
  ),

  RepositoryProvider(
    create: (context) => PaymentRepository(client: context.read<ApiClient>()),
  ),

  RepositoryProvider(
    create: (context) => AddressRepo(client: context.read<ApiClient>()),
  ),

  BlocProvider(
    create: (context) => AddressBloc(repository: context.read<AddressRepo>()),
  ),

  BlocProvider(
    create: (context) =>
        PaymentBloc(repository: context.read<PaymentRepository>()),
  ),
];
