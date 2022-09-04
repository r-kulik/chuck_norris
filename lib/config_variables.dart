import 'package:chuck_norris/category_button.dart';
import 'package:flutter/material.dart';

String chuckTinderApplicationTitle = "Tinder With Chuck";

MaterialColor applicationPrimarySwatch = Colors.blue;
MaterialColor highlightColorForMenuIcons = Colors.grey;
Color jokeCardHolderBorderColor = Colors.black;

IconData iconForMainPage = Icons.home;
MaterialColor iconForMainPageColor = Colors.blue;
IconData iconForFavourites = Icons.favorite;
MaterialColor iconForFavouritesColor = Colors.red;

String nextJokeButtonText = "I liked.\nNext one!";

List<String> categoryRequestParameters = [
  "no category",
  "animal",
  "career",
  "celebrity",
  "dev",
  "explicit",
  "fashion",
  "food",
  "history",
  "money",
  "movie",
  "music",
  "political",
  "religion",
  "science",
  "sport",
  "travel"
];
List<Category> categories = List<Category>.generate(
    categoryRequestParameters.length,
    (index) => Category(categoryRequestParameters[index]));

String apiDomain = "api.chucknorris.io";
String domainPath = "/jokes/random";

String missingNetworkJokeCardId = "missing_network_joke_card_id";
