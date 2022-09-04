import 'dart:convert';
import 'dart:io';

import 'package:chuck_norris/joke_card.dart';
import 'package:chuck_norris/config_variables.dart';
import 'package:flutter/cupertino.dart';
import 'category_button.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<JokeCard> updateJokeAccordingToCategory(Category category) async {
  // There is obviously no "no category" category :)
  // So wee need unpleasant if-else block
  Uri url;
  // print(category == categories[0]);
  if (category == categories[0]) {
    url = Uri.http(apiDomain, domainPath);
  } else {
    url = Uri.http(
        apiDomain, domainPath, {"category": category.requestParameter});
  }
  try {
    http.Response response = await http.get(url);
    // print(jsonDecode(response.body));
    JokeModel jokeModel = JokeModel.fromJson(jsonDecode(response.body));
    //print(jokeModel);
    bool isFavourite = await checkJokeCardIsInFavouritesById(jokeModel.id);
    // print("Is Favourite: $isFavourite");
    JokeCard cardToReturn = JokeCard(jokeModel, isFavourite);
    return cardToReturn;
  } on Exception catch (_) {
    return JokeCard(
        JokeModel.fromJson({
          "url": "",
          "id": missingNetworkJokeCardId,
          "value": "Sorry, something got wrong with network ;("
        }),
        false);
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/favourites.txt');
}

Future<Map<String, dynamic>> getFavouritesModelsFromFile() async {
  final file = await _localFile;
  final String content = await file.readAsString();
  try {
    Map<String, dynamic> favourites = jsonDecode(content);
    return favourites;
  } catch (e) {
    return {};
  }
}

void uploadFavouritesToFile(Map<String, dynamic> favourites) async {
  final file = await _localFile;
  file.writeAsString(jsonEncode(favourites));
}

Future<bool> checkJokeCardIsInFavourites(JokeCard card) async {
  Map<String, dynamic> favourites = await getFavouritesModelsFromFile();
  return favourites.containsKey(card.jokeModel.id);
}

Future<bool> checkJokeCardIsInFavouritesById(String cardId) async {
  Map<String, dynamic> favourites = await getFavouritesModelsFromFile();
  return favourites.containsKey(cardId);
}

void addToFavourites(JokeCard card) async {
  if (card.jokeModel.id.compareTo(missingNetworkJokeCardId) != 0) {
    Map<String, dynamic> favourites = await getFavouritesModelsFromFile();
    favourites[card.jokeModel.id] = card.jokeModel;
    uploadFavouritesToFile(favourites);
  }
}

void deleteFromFavourites(JokeCard card) async {
  Map<String, dynamic> favourites = await getFavouritesModelsFromFile();
  favourites.remove(card.jokeModel.id);
  uploadFavouritesToFile(favourites);
}

Future<List<JokeCard>> getFavouriteJokeCards() async {
  Map<String, dynamic> favourites = await getFavouritesModelsFromFile();
  List<JokeCard> listToReturn = [];
  for (String favouriteKey in favourites.keys) {
    listToReturn
        .add(JokeCard(JokeModel.fromJson(favourites[favouriteKey]), true));
  }
  return listToReturn;
}
