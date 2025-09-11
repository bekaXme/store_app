import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:store_app/core/services/client.dart';
import 'package:store_app/data/repositories/auth/auth_repository.dart';
import 'core/routing/routers.dart' as AppRouter;

main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => AuthRepository(ApiClient())),
      ],
      child: const StoreApp(),
    )
  );
}

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
