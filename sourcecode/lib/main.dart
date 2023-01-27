import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:suitmedia/bloc/user_bloc.dart';
import 'package:suitmedia/cubit/palindrome_cubit.dart';
import 'package:suitmedia/repository/user_repository.dart';
import 'package:suitmedia/util/app_theme.dart';
import 'package:suitmedia/util/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark
        )
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return RepositoryProvider(
      create: (context) => UserRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PalindromeCubit(),
          ),
          BlocProvider(
            create: (context) => UserBloc(userRepository: RepositoryProvider.of<UserRepository>(context)),
          )
        ],
        child: ResponsiveSizer(
          builder: (context, orientation, screenType){
            return MaterialApp(
              title: 'Suitmedia',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.theme(),
              builder: EasyLoading.init(),
              onGenerateRoute: Routes.onGenerateRoutes,
              initialRoute: Routes.firstScreen,
            );
          },
        ),
      ),
    );
  }
}