import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:store_app/core/services/client.dart';
import 'package:store_app/data/repositories/auth/auth_repository.dart';
import 'core/routing/routers.dart' as AppRouter;
import 'dependencies.dart';
import 'features/auth/managers/authlogin_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: dependencies,
      child: const StoreApp(),
    ),
  );
}

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X reference size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'My App',
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
