import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:store_app/core/interceptor/auth_interceptor.dart';
import 'package:store_app/core/services/client.dart';
import 'package:store_app/data/repositories/productItem/product_item_repository.dart';
import 'package:store_app/features/notifications/managers/notifications_cubit.dart';
import 'package:store_app/data/repositories/notifications/notifications_repository.dart';
import 'package:store_app/features/home/cubit/home_cubit.dart';
import 'package:store_app/data/repositories/auth/auth_repository.dart';
import 'package:store_app/data/repositories/home/home_repository.dart';
import 'package:store_app/features/auth/managers/authlogin_view_model.dart';
import 'data/repositories/savedProducts/saved_products_repository.dart';
import 'features/productDetail/managers/product_detail_bloc.dart';
import 'features/savedProducts/bloc/saved_product_cubit.dart';

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

  BlocProvider<SavedCubit>(
    create: (context) =>
        SavedCubit(productRepo: context.read<SavedProductsRepository>()),
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
];
