import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_app/Presentation/onboarding/view/onboarding_view.dart';
import 'package:flutter_mvvm_app/Presentation/resources/strings_manager.dart';

import '../../App/dependency_injection.dart';
import '../forgot_password/forgot_password_view/forgot_password_view.dart';
import '../login/view/login_view.dart';
import '../main/main_view.dart';
import '../register/register_view/register_view.dart';
import '../splash/splash_view.dart';
import '../store _details/store_details_view/store_details_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String onBoardingRoute = "/onBoarding";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgotPasswordRoute:
        initForgotModule();
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailsRoute:
        initStoreDetailsModule();
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text(
                AppStrings.noRouteFound).tr(),
          ),
          body:  Center(
              child: const Text(
                  AppStrings.noRouteFound).tr()),
        ));
  }
}