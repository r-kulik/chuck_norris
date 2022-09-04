import 'package:chuck_norris/category_button.dart';
import 'package:chuck_norris/main_page.dart';
import 'package:chuck_norris/config_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NextJokeButton extends StatelessWidget {
  const NextJokeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: jokeCardHolderBorderColor, width: 1),
        borderRadius: BorderRadius.circular(25),
      ),
      child: BlocBuilder<CategoryCubit, Category>(builder: (context, state) {
        return TextButton(
          onPressed: () => // throw Exception(),
              context.read<JokeCardCubit>().refreshJokeCard(state),
          child: Text(
            nextJokeButtonText,
            textAlign: TextAlign.center,
          ),
        );
      }),
    );
  }
}
