import 'package:chuck_norris/category_button.dart';
import 'package:chuck_norris/joke_card_holder.dart';
import 'package:chuck_norris/navigation_tab_bar.dart';
import 'package:chuck_norris/next_joke_button.dart';
import 'package:chuck_norris/config_variables.dart';
import 'package:chuck_norris/updating_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'joke_card.dart';

class CategoryCubit extends Cubit<Category> {
  CategoryCubit() : super(Category(categoryRequestParameters[0]));
  void changeCategory(Category newCategory) {
    emit(newCategory);
  }
}

class JokeCardCubit extends Cubit<JokeCard?> {
  JokeCardCubit() : super(null);

  void refreshJokeCard(Category category) async {
    emit(await updateJokeAccordingToCategory(category));
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    JokeCardHolder jokeCardHolderWidget = const JokeCardHolder();
    CategoryButton categoryButton = const CategoryButton();
    return BlocProvider(
      create: (_) => CategoryCubit(),
      child: BlocProvider(
        create: (_) => JokeCardCubit(),
        child: SafeArea(child: Scaffold(body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: jokeCardHolderBorderColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12)),
                height: constraints.maxHeight * 0.1,
                width: constraints.maxWidth * 0.5,
                child: categoryButton,
              ),
              Padding(padding: EdgeInsets.all(constraints.maxHeight * 0.01)),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: jokeCardHolderBorderColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  width: constraints.maxWidth * 0.9,
                  height: constraints.maxHeight * 0.5,
                  child: jokeCardHolderWidget),
              Padding(padding: EdgeInsets.all(constraints.maxHeight * 0.025)),
              SizedBox(
                  width: constraints.maxWidth * 0.50,
                  height: constraints.maxHeight * 0.10,
                  child: const NextJokeButton()),
              Padding(padding: EdgeInsets.all(constraints.maxHeight * 0.025)),
              SizedBox(
                height: 40,
                width: constraints.maxWidth,
                child: const NavigationTabBar(0),
              )
            ],
          );
        }))),
      ),
    );
  }
}
