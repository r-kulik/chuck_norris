import 'package:flutter/material.dart';
import 'favourites_page.dart';
import 'main_page.dart';
import 'config_variables.dart';

class ChuckTinderApplication extends StatelessWidget {
  const ChuckTinderApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: chuckTinderApplicationTitle,
      theme: ThemeData(primarySwatch: applicationPrimarySwatch),
      routes: {
        '/': (BuildContext context) => const MainPage(),
        '/favourites': (BuildContext context) => const FavouritesPage()
      },
    );
  }
}
