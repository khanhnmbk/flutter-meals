import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorite_provider.dart';
import 'package:meals/widgets/meal_detail_item.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: () {
                final wasAdded = ref
                    .read(favoriteMealsProvider.notifier)
                    .toggleMealFavoriteStatus(meal);

                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(wasAdded
                        ? 'Meal added as favorite'
                        : 'Meal removed from favorite')));
              },
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Icon(isFavorite ? Icons.star : Icons.star_border,
                    key: ValueKey(isFavorite)),
                transitionBuilder: (child, animation) {
                  return RotationTransition(
                    turns: Tween(begin: 0.75, end: 1.0).animate(animation),
                    child: child,
                  );
                },
              ))
        ],
      ),
      body: MealDetailItem(meal: meal),
    );
  }
}
