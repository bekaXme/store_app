import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:store_app/features/onboarding/pages/get_started_page.dart';
import '../../data/repositories/auth/auth_repository.dart';
import '../../features/auth/managers/auth_view_model.dart';
import '../../features/auth/pages/register_page.dart';
import '../../features/onboarding/pages/onboarding_main.dart';

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
    GoRoute(
      path: '/login',
      builder: (context, state) => const GetStartedPage(),
    ),
  ],
);
