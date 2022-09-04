import 'package:chuck_norris/config_variables.dart';
import 'package:flutter/material.dart';

class NavigationTabBar extends StatelessWidget {
  final int iconSelectedIndex;
  const NavigationTabBar(this.iconSelectedIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<IconData> iconImages = [iconForMainPage, iconForFavourites];
    List<String> routes = ['/', '/favourites'];
    List<Color> colorsForSelected = [
      iconForMainPageColor,
      iconForFavouritesColor
    ];
    List<NavigationButton> childrenList = List<NavigationButton>.generate(
        iconImages.length,
        (index) => NavigationButton(
            iconImages[index],
            routes[index],
            (index == iconSelectedIndex)
                ? colorsForSelected[index]
                : Colors.black));
    return BottomAppBar(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: childrenList),
    );
  }
}

class NavigationButton extends StatelessWidget {
  final IconData iconImage;
  final String route;
  final Color buttonColor;

  const NavigationButton(this.iconImage, this.route, this.buttonColor,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IconButton(
        onPressed: () => Navigator.popAndPushNamed(context, route),
        color: buttonColor,
        highlightColor: buttonColor,
        icon: Icon(iconImage));
  }
}
