
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:RadianceAI/commons/Welcome.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'bloc/setting_bloc.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late bool _theme;
  List<String> languageCode = ['en_US', 'fr'];
  List<String> languageName = ['English', 'Français'];
  String currentLanguage = "English";
  @override
  void initState(){
    super.initState();
    _theme = BlocProvider.of<SettingBloc>(context).theme =='dark';
    Locale lang = LocalizedApp.of(context).delegate.currentLocale;
    currentLanguage = languageName[languageCode.indexOf(lang.toString())];
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                const Welcome(
                  defaultIndex: 0,
                ),
              ),
            );
          },
        ),
        title: const Text('Setting'),
      ),
      body: BlocConsumer<SettingBloc, SettingState>(
        listener: (context, state) async {
          if (state is SettingLoadedError) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    duration: const Duration(seconds: 10),
                    content: Text(state.error)));
          } else if (state is SettingsLoaded) {
            await changeLocale(
              context,
              state.settings.language,
            );
            setState(() {
              _theme = BlocProvider
                  .of<SettingBloc>(context)
                  .theme == 'dark';
              Locale lang = LocalizedApp
                  .of(context)
                  .delegate
                  .currentLocale;
              currentLanguage =
              languageName[languageCode.indexOf(lang.toString())];
            });
          }
        },
        builder: (BuildContext context, SettingState state) {
          if (state is SettingsLoaded) {
            bool _isDark = state.settings.theme == 'dark' ? true : false;
            return Center(
              child:
              Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                  Widget>[
                Card(
                  margin: const EdgeInsets.only(top: 10.0),
                  elevation: 4.0,
                  shadowColor: Colors.indigo,
                  child: SwitchListTile(
                    title: const Text('dark'),
                    value: _theme,
                    activeColor: Colors.indigo.shade100,
                    onChanged: (bool value) {
                      BlocProvider.of<SettingBloc>(context).add(
                          UpdateSettingStringValue(
                              key: 'theme', value: value ? 'dark' : 'light'));
                    },
                    secondary: Icon(
                        _isDark == false ? Icons.light_mode : Icons.dark_mode),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(top: 10.0),
                  elevation: 4.0,
                  shadowColor: Colors.indigo,
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                      ),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (String? newValue) {
                        BlocProvider.of<SettingBloc>(context).add(
                            UpdateSettingStringValue(
                                key: 'language',
                                value: languageCode[
                                languageName.indexOf(newValue!)]));
                      },
                      value: currentLanguage,
                      items: languageName
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),


              ]),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },


      ),


    );
  }


  }

