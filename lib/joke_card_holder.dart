import 'package:chuck_norris/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'joke_card.dart';

class JokeCardHolder extends StatefulWidget {
  const JokeCardHolder({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => JokeCardHolderState();
}

class JokeCardHolderState extends State<JokeCardHolder> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JokeCardCubit, JokeCard?>(builder: (context, state) {
      return Container(
          padding: const EdgeInsets.all(12),
          child: state != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    state,
                  ],
                )
              : null);
    });
  }
}
