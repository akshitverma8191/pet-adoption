import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petadoption/core/route/routes.dart';

import '../../view/splash.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {

    case Routes.splash:
      return MaterialPageRoute(builder: (_) => const SplashScreen());

    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                appBar: AppBar(
                  title:  Text('Invalid Page ${settings.name}'),
                ),
              ));
  }
}
