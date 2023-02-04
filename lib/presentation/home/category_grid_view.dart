import 'package:flutter/material.dart';

class CategoryGridView extends StatelessWidget {
  Category category;
  int index;
  Function onClickItem;

  CategoryGridView({
    required this.category,
    required this.index,
    required this.onClickItem,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClickItem(category);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: category.categoryBackground,
          borderRadius: BorderRadius.only(
            topRight: const Radius.circular(20),
            topLeft: const Radius.circular(20),
            bottomLeft: Radius.circular(index % 2 == 0 ? 25 : 0),
            bottomRight: Radius.circular(index % 2 == 0 ? 0 : 25),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(category.categoryImage),
            Text(
              category.categoryTitle,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}

class Category {
  String categoryID;
  String categoryImage;
  String categoryTitle;
  Color categoryBackground;

  Category({
    required this.categoryID,
    required this.categoryImage,
    required this.categoryTitle,
    required this.categoryBackground,
  });
}
