import 'package:bring_the_menu/models/dish.dart';
import 'package:get/get.dart';

class DishMenuController extends GetxController {
  // RxList dishes = [].obs;
  // RxList <DishModel>? dishes = [].obs as RxList<DishModel>?;

  List <DishModel> dishes = [];
  RxInt totalDishes = 0.obs;

  addDish(String name, String price, String type) {
    if (name.isEmpty || price.isEmpty || type.isEmpty) {
      Get.defaultDialog(
          title: 'Error', middleText: 'Please provide all details,');
      return;
    }

    DishModel newDish = DishModel(
        name: name, price: price, type: type == 'Veg' ? 'Veg' : 'Non-Veg');

    dishes.add(newDish);
    totalDishes.value = dishes.length;
    print('Dish Added: ${dishes[0].name}');
  }

  getTotalDishes() {
    return dishes;
  }
}
