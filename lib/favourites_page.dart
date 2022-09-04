import 'package:chuck_norris/joke_card.dart';
import 'package:chuck_norris/navigation_tab_bar.dart';
import 'package:chuck_norris/updating_functions.dart';
import 'package:flutter/material.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight - 40,
                child: FutureBuilder(
                    future: getFavouriteJokeCards(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const Text("Loading favourites...");
                      }
                      List<JokeCard> favouriteJokeCards =
                          snapshot.data as List<JokeCard>;
                      List<Widget> favouriteJokeCardsWithPaddings = [];
                      for (JokeCard jokeCard in favouriteJokeCards) {
                        favouriteJokeCardsWithPaddings.add(jokeCard);
                        favouriteJokeCardsWithPaddings.add(const Padding(
                          padding: EdgeInsets.all(5),
                        ));
                      }
                      return ListView(
                          padding: const EdgeInsets.all(5),
                          children: favouriteJokeCardsWithPaddings);
                    }),
              ),
              SizedBox(
                  height: 40,
                  width: constraints.maxWidth,
                  child: const NavigationTabBar(1))
            ],
          );
        },
      )),
    );
  }
}
