import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:store_app/core/interceptor/auth_interceptor.dart';
import 'package:store_app/core/services/client.dart';
import 'package:store_app/cubit/home/home_cubit.dart';
import 'package:store_app/data/repositories/auth/auth_repository.dart';
import 'package:store_app/data/repositories/home/home_repository.dart';
import 'package:store_app/features/auth/managers/authlogin_view_model.dart';

final List<SingleChildWidget> dependencies = [
  Provider(create: (context) => FlutterSecureStorage()),

  Provider(create: (context) => AuthInterceptor(secureStorage: context.read())),

  ProxyProvider<AuthInterceptor, ApiClient>(
    update: (_, interceptor, __) => ApiClient(interceptor: interceptor),
  ),

  Provider<AuthRepository>(create: (context) => AuthRepository(context.read<ApiClient>())),

  ChangeNotifierProvider(
    create: (context) => AuthVM(context.read<AuthRepository>()),
  ),

  Provider<HomeRepository>(create: (context) => HomeRepository(context.read<ApiClient>())),

  BlocProvider<HomeCubit>(
    create: (context) => HomeCubit(context.read<HomeRepository>())..loadData(),
  ),
];
