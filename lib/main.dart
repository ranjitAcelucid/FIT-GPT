import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales/cubit/auth/auth_cubit.dart';
import 'package:sales/cubit/product/diet/diet_cubit.dart';
import 'package:sales/di.dart';
import 'package:sales/utils/services/navigation_service.dart';
import 'package:sales/utils/services/route_constant.dart';
import 'package:sales/utils/services/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  // Lock the orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Lock to portrait
    // DeviceOrientation.landscapeLeft, // Lock to landscape (uncomment if needed)
    // DeviceOrientation.landscapeRight, // Lock to another landscape mode
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DietPlanCubit>(create: (context) => DietPlanCubit()),
      ],
      child: MaterialApp(
        // home: const SplashScreen(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child!,
          );
        },
        themeMode: ThemeMode.system,
        navigatorKey: navigatorKey,
        theme: ThemeData(
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(
            color: Colors.transparent,
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
