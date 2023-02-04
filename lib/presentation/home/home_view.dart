// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:news_app/presentation/category/category_widget.dart';

import 'category_grid_view.dart';

class HomeView extends StatefulWidget {
  static const String routeName = "homeView";

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Category> category = [
    Category(
      categoryID: "sports",
      categoryImage: "assets/images/sports.png",
      categoryTitle: "Sports",
      categoryBackground: const Color.fromARGB(255, 201, 28, 34),
    ),
    Category(
      categoryID: "general",
      categoryImage: "assets/images/Politics.png",
      categoryTitle: "General",
      categoryBackground: const Color.fromARGB(255, 0, 62, 144),
    ),
    Category(
      categoryID: "health",
      categoryImage: "assets/images/health.png",
      categoryTitle: "Health",
      categoryBackground: const Color.fromARGB(255, 237, 30, 121),
    ),
    Category(
      categoryID: "business",
      categoryImage: "assets/images/bussines.png",
      categoryTitle: "Business",
      categoryBackground: const Color.fromARGB(255, 207, 126, 72),
    ),
    Category(
      categoryID: "technology",
      categoryImage: "assets/images/environment.png",
      categoryTitle: "Technology",
      categoryBackground: const Color.fromARGB(255, 72, 130, 207),
    ),
    Category(
      categoryID: "science",
      categoryImage: "assets/images/science.png",
      categoryTitle: "Science",
      categoryBackground: const Color.fromARGB(255, 242, 211, 82),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Image.asset(
            "assets/images/pattern.png",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              selectedCategory == null
                  ? "Route News App"
                  : selectedCategory!.categoryTitle,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 22,
              ),
            ),
            centerTitle: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            )),
          ),
          drawer: Drawer(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 45),
                  width: double.infinity,
                  height: 120,
                  color: Colors.green,
                  child: const Text(
                    "News App!",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedCategory = null;
                        Navigator.pop(context);
                      });
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.menu,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Categories",
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {

                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.settings,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Settings",
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: selectedCategory == null
              ? Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pick your category \n of interest",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.black54,
                            ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 6 / 7,
                          ),
                          itemBuilder: (context, index) => CategoryGridView(
                            index: index,
                            category: category[index],
                            onClickItem: onClick,
                          ),
                          itemCount: category.length,
                        ),
                      ),
                    ],
                  ),
                )
              : CategoryNewsList(selectedCategory!),
        ),
      ],
    );
  }

  Category? selectedCategory;

  void onClick(Category category) {
    setState(() {
      selectedCategory = category;
    });
  }
}
