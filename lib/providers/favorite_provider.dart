import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final isFavorite = state.contains(meal);
    if (isFavorite) {
      state = state.where((element) => element.id != meal.id).toList();
      return false;
      //state.remove(meal);
    } else {
      state = [...state, meal];
      return true;
      //state.add(meal);
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
