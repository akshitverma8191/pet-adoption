import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petadoption/core/route/routes.dart';
import 'package:petadoption/model/animal_model.dart';
import 'package:petadoption/view/history/history_page.dart';
import 'package:petadoption/view/home/home_page.dart';

import '../../view/datail/detail_page.dart';
import '../../view/home/bloc/home_bloc.dart';
import '../../view/splash.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.splash:
      return MaterialPageRoute(builder: (_) => const SplashScreen());

    case Routes.homePage:
      return MaterialPageRoute(builder: (_) => const HomePage());
    case Routes.detailPage:
      return MaterialPageRoute(builder: (_) =>  DetailPage(animalModel: settings.arguments as AnimalModel,));

    case Routes.historyPage:
      return MaterialPageRoute(builder: (_) => const HistoryPage());
    default:
      return MaterialPageRoute(
          builder: (_) =>
              Scaffold(
                appBar: AppBar(
                  title: Text('Invalid Page ${settings.name}'),
                ),
              ));
  }
}
