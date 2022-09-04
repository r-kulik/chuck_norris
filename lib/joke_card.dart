import 'package:chuck_norris/updating_functions.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

part 'joke_card.g.dart';

@JsonSerializable()
class JokeModel {
  final String url;
  final String value;
  final String id;
  JokeModel({required this.url, required this.value, required this.id});
  factory JokeModel.fromJson(Map<String, dynamic> json) =>
      _$JokeModelFromJson(json);
  Map<String, dynamic> toJson() => _$JokeModelToJson(this);
}

class JokeCard extends StatelessWidget {
  final JokeModel jokeModel;
  final bool wasLiked;

  JokeCard(this.jokeModel, this.wasLiked, {Key? key}) : super(key: key) {
    // print("JokeCard.wasLiked = $wasLiked");
  }

  @override
  Widget build(BuildContext context) {
    LikeButton likeButtonForThisCard =
        LikeButton(this, key: ValueKey<String>(jokeModel.id));
    return Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black, width: 1)),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SingleChildScrollView(child: Text(jokeModel.value))],
          ),
          const Padding(padding: EdgeInsets.all(4)),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1)),
          ),
          const Padding(padding: EdgeInsets.all(4)),
          Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [likeButtonForThisCard]))
        ]));
  }
}

class LikeButton extends StatefulWidget {
  final JokeCard jokeCard;
  const LikeButton(this.jokeCard, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool wasLiked = false;

  void pressLike() {
    if (!wasLiked) {
      addToFavourites(widget.jokeCard);
      setState(() => wasLiked = true);
    } else {
      deleteFromFavourites(widget.jokeCard);
      setState(() => wasLiked = false);
    }
  }

  @override
  void initState() {
    super.initState();
    wasLiked = widget.jokeCard.wasLiked;
  }

  @override
  void didUpdateWidget(LikeButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.jokeCard.wasLiked != widget.jokeCard.wasLiked) {
      initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (wasLiked) {
      return IconButton(
        icon: const Icon(
          Icons.favorite,
          color: Colors.redAccent,
        ),
        onPressed: pressLike,
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.favorite_border, color: Colors.black),
        onPressed: pressLike,
      );
    }
  }
}
