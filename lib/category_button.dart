import 'package:chuck_norris/config_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_page.dart';

class Category {
  late String name;
  final String requestParameter;

  Category(this.requestParameter) {
    name = requestParameter[0].toUpperCase() + requestParameter.substring(1);
  }

  @override
  bool operator ==(covariant Category other) {
    return name.compareTo(other.name) == 0;
  }

  @override
  int get hashCode => super.hashCode + 1;
}

class CategoryButton extends StatefulWidget {
  const CategoryButton({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CategoryButtonState();
}

class CategoryButtonState extends State<CategoryButton> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopupMenuButton(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          BlocBuilder<CategoryCubit, Category>(
              builder: (context, Category state) {
            return Text(state.name);
          })
        ]),
        onSelected: (value) => {
              setState(() => context
                  .read<CategoryCubit>()
                  .changeCategory(categories[value as int]))
            },
        itemBuilder: (context) => List<PopupMenuItem>.generate(
            categoryRequestParameters.length,
            (index) => PopupMenuItem(
                value: index, child: Text(categories[index].name))));
  }
}
