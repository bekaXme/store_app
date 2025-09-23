import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:store_app/data/repositories/savedProducts/saved_products_repository.dart';
import 'package:store_app/features/auth/managers/reset_password_view_model.dart';
import 'package:store_app/features/auth/pages/login_page.dart';
import 'package:store_app/features/auth/pages/reset_password_page.dart';
import 'package:store_app/features/home/pages/home_page.dart';
import 'package:store_app/features/notifications/pages/notifications_page.dart';
import 'package:store_app/features/onboarding/pages/get_started_page.dart';
import 'package:store_app/features/savedProducts/bloc/saved_product_bloc.dart';
import 'package:store_app/features/savedProducts/pages/saved_product_page.dart';
import '../../data/repositories/auth/auth_repository.dart';
import '../../features/auth/managers/authlogin_view_model.dart';
import '../../features/auth/pages/get_otp_page.dart';
import '../../features/auth/pages/new_password_page.dart';
import '../../features/auth/pages/register_page.dart';
import '../../features/onboarding/pages/onboarding_main.dart';
import '../../features/productDetail/pages/product_detail_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/onboardingBegin',
  routes: [
    GoRoute(
      path: '/onboardingBegin',
      builder: (context, state) => const OnBoardingPage(),
    ),
    GoRoute(
      path: '/getStarted',
      builder: (context, state) => const GetStartedPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => AuthVM(context.read<AuthRepository>()),
        child: const RegisterPage(),
      ),
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/home', builder: (context, state) => HomePage()),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationsPage(),
    ),
    GoRoute(
      path: '/savedProducts',
      builder: (context, state) => const SavedProductsPage(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return ProductDetailPage(productId: id);
      },
    ),
    ShellRoute(
      builder: (context, state, child) => ChangeNotifierProvider(
        create: (context) => ResetPasswordVM(context.read<AuthRepository>()),
        child: child,
      ),
      routes: [
        GoRoute(
          path: '/reset_password',
          builder: (context, state) => const ResetPasswordPage(),
        ),
        GoRoute(
          path: '/get_otp',
          builder: (context, state) {
            final email = state.extra as String;
            return OtpPage(email: email);
          },
        ),
        GoRoute(
          path: '/new_password',
          builder: (context, state) => const NewPasswordPage(),
        ),
      ],
    ),
  ],
);
