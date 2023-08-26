import 'package:RadianceAI/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:RadianceAI/login/auth_repo.dart';

import 'Setting/bloc/setting_bloc.dart';
import 'Setting/setting_repo.dart';
import 'Setting/theme.dart';
import 'commons/Welcome.dart';
import 'login/auth_repo.dart';
import 'login/bloc/auth_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() async {
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en_US', supportedLocales: ['en_US', 'fr']);

  runApp(LocalizedApp(delegate, MyApp()));
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
        BlocProvider(
            create: (_) => SettingBloc(settingService: SettingService())
              ..add(GetSavedSettings())),
      ], child: _buildWithTheme(context),


    );
  }

  Widget _buildWithTheme(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return BlocBuilder<SettingBloc, SettingState>(builder: (context, state) {
      AppTheme _theme = AppTheme.light;
      String _language = 'fr';
      if (state is SettingsLoaded) {
        _theme =
        state.settings.theme == 'dark' ? AppTheme.dark : AppTheme.light;
        _language = state.settings.language;
      }
      return LocalizationProvider(
          state: LocalizationProvider.of(context).state,
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      localizationDelegate,
      GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: localizationDelegate.supportedLocales,
      locale: Locale.fromSubtags(languageCode: _language),
      title: 'RadianceAI',
      theme: appThemeData[_theme],
      initialRoute: "login",
      routes: {
        'login' :(context) =>const Login(),
      "/": (context) => const Welcome(
      defaultIndex: 0,
      ),
      }));
    },
    );
  }
}
