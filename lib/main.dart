// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projexity/pages/navigation.dart';
import 'package:projexity/pages/onboarding_screen.dart';
import 'package:projexity/repositories/databases/database_repository.dart';
import 'package:projexity/repositories/storage/storage_repository,.dart';
import 'blocs/onboarding/onboarding_bloc.dart';
import 'firebase_options.dart';
//import 'package:projexity/pages/login_page.dart';
import 'package:projexity/pages/auth_page.dart';

import 'pages/start_page.dart';
import 'package:equatable/equatable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: OnBoardingScreen(), //StartPage()

    // );
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => DatabaseRepository(),
          ),
          RepositoryProvider(
            create: (context) => StorageRepository(),
          )
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<OnboardingBloc>(
              create: (context) => OnboardingBloc(
                databaseRepository: context.read<DatabaseRepository>(),
                storageRepository: context.read<StorageRepository>(),
              ),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: StartPage(),
          ),
        ));
  }
}
