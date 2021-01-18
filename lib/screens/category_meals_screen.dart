import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

//screen that shows meals for a category

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  // final String categoryId;
  // final String categoryTitle;

  // CategoryMealsScreen(this.categoryId, this.categoryTitle);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle; //mutable
  List<Meal> displayedMeals;
  var _loadedInitData = false;

  //derive meals earlier than in the build method
  @override
  void initState() {
    //don't need to call setState here because this will automatically run before build runs the first time
    // ...
    super.initState();
  }

  //another lifecycle hook
  //not used often
  //reusable because this will be triggered essentially whenever the reference of the state change which also means
  //it will be called when the widget that belongs to the state has been fully initialized and we can tap into
  //context
  //this will still run before build runs
  //this runs a couple of times after the initializtion of this state, unlike initState
  //it runs whenever the dependencies of this state changes and that's also the case when the attached widget changes,
  //which is the case when we call setState in _removeMeal
  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          //this is how we extract route arguments
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
      //now this code will only run for the first time
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      //i want to remove an item from displayedMeals
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            affordability: displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
