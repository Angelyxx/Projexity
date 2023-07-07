// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projexity/cubits/login/login_cubit.dart';
import 'package:projexity/cubits/signup/signup_cubit.dart';
import 'package:projexity/pages/navigation.dart';
import 'package:projexity/pages/onboarding_screen.dart';
import 'package:projexity/pages/start_page%20copy.dart';
import 'package:projexity/repositories/auth_repository.dart';
import 'package:projexity/repositories/databases/database_repository.dart';
import 'package:projexity/repositories/storage/storage_repository,.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/onboarding/onboarding_bloc.dart';
import 'blocs/profile/profile_bloc.dart';
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
            create: (context) => AuthRepository(),
          ),
          RepositoryProvider(
            create: (context) => DatabaseRepository(),
          ),
          RepositoryProvider(
            create: (context) => StorageRepository(),
          )
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(
                authRepository: context.read<AuthRepository>(),
              ),
            ),
            BlocProvider<OnboardingBloc>(
              create: (context) => OnboardingBloc(
                databaseRepository: context.read<DatabaseRepository>(),
                storageRepository: context.read<StorageRepository>(),
              ),
            ),
            BlocProvider<SignupCubit>(
              create: (context) =>
                  SignupCubit(authRepository: context.read<AuthRepository>()),
            ),
            BlocProvider<LoginCubit>(
              create: (context) =>
                  LoginCubit(authRepository: context.read<AuthRepository>()),
            ),
            BlocProvider(
              create: (context) => ProfileBloc(
                //authBloc: BlocProvider.of<AuthBloc>(context),
                databaseRepository: context.read<DatabaseRepository>(),
              )..add(
                  LoadProfile(userId: FirebaseAuth.instance.currentUser!.uid
                      //BlocProvider.of<AuthBloc>(context).state.user!.uid''
                      ),
                ),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            //home: StartPageCopy(),
            home: StartPage(),
          ),
        ));
  }
}
