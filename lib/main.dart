import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radianceAI/login/auth_repo.dart';
import 'package:radianceAI/login/login.dart';

import 'Setting/theme.dart';
import 'commons/Welcome.dart';
import 'login/bloc/auth_bloc.dart';


void main() {
  runApp(const MaterialApp(home: Login()),);
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  AuthenticationService authenticationService = AuthenticationService();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
          AuthenticationBloc(authenticationService: authenticationService)
            ..add(GetSession()),
        ),
      ], child: _buildWithTheme(context),


    );
  }
  Widget _buildWithTheme(BuildContext context ){
    return BlocBuilder<SettingBloc, SettingState>(builder: (context, state) {
      AppTheme _theme = AppTheme.light;
      String _language = 'fr';
      if (state is SettingsLoaded) {
        _theme =
        state.settings.theme == 'dark' ? AppTheme.dark : AppTheme.light;
        _language = state.settings.language;

  }
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: Locale.fromSubtags(languageCode: _language),
        title: 'RadianceAI',
        theme: appThemeData[_theme],
        initialRoute: "/",
        routes: {
          '/' :(context) => const Welcome(defaultIndex: 0,),
      });
        },
      );
}


// theme: ThemeData.dark().copyWith(
// textTheme: const TextTheme(
// bodyText1: TextStyle(color: Colors.black54),
// ),
// ),
// initialRoute:'/' ,
// routes: {
// '/':(context) =>const Welcome(defaultIndex: 0,),
// 'login':(context)=> const Login(),
