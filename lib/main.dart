import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petadoption/core/route/route_generator.dart';
import 'package:petadoption/core/route/routes.dart';
import 'package:petadoption/view/home/bloc/home_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [ BlocProvider(create: (BuildContext context) => HomeBloc()),],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal.shade300),
          useMaterial3: true,
        ),
        initialRoute: Routes.splash,
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}

