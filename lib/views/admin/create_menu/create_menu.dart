import 'package:bring_the_menu/constants.dart';
import 'package:bring_the_menu/controllers/menu_controller.dart';
import 'package:bring_the_menu/models/dish.dart';
import 'package:bring_the_menu/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateMenu extends StatefulWidget {
  const CreateMenu({super.key});

  @override
  State<CreateMenu> createState() => _CreateMenuState();
}

class _CreateMenuState extends State<CreateMenu> {
  final constants = Get.put(Constants());
  TextEditingController dishController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  bool isVeg = false;
  bool isNonVeg = false;
  bool isValueAdded = false;

  final menuController = Get.put(DishMenuController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(
            left: Get.width / 30, right: Get.width / 30, top: Get.width / 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create Menu 😋',
              style: TextStyle(
                  color: constants.whiteTextColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: Get.height / 40),
            Text('Add Item',
                style: TextStyle(
                    color: constants.whiteTextColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: Get.height / 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: Get.width / 1.45,
                  height: Get.height / 17,
                  decoration: BoxDecoration(
                      color: constants.inputBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: constants.inputStrokeColor)),
                  child: TextFormField(
                    controller: dishController,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'eg: Kadhai Paneer',
                      hintStyle: TextStyle(
                          color: constants.inputHintTextColor,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                      contentPadding: const EdgeInsets.all(14),
                    ),
                  ),
                ),
                SizedBox(width: Get.width / 30),
                Container(
                  width: Get.width / 5,
                  height: Get.height / 17,
                  decoration: BoxDecoration(
                      color: constants.inputBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: constants.inputStrokeColor)),
                  child: TextFormField(
                    controller: priceController,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Price',
                      hintStyle: TextStyle(
                          color: constants.inputHintTextColor,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                      contentPadding: const EdgeInsets.all(14),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: Get.width / 20),
            CheckboxListTile(
              title: Text(
                "Veg",
                style: TextStyle(color: constants.whiteTextColor),
              ),
              value: isVeg,
              checkColor: Colors.green,
              activeColor: Colors.green,
              onChanged: (newValue) {
                setState(() {
                  if (isVeg == false) {
                    if (isNonVeg == true) {
                      Get.snackbar('Error', 'Select only one option').show();
                      return;
                    }
                    isVeg = true;
                  } else {
                    isVeg = false;
                  }
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text(
                "Non-Veg",
                style: TextStyle(color: constants.whiteTextColor),
              ),
              value: isNonVeg,
              checkColor: Colors.red,
              activeColor: Colors.red,
              onChanged: (newValue) {
                setState(() {
                  if (isNonVeg == false) {
                    if (isVeg == true) {
                      Get.snackbar('Error', 'Select only one option').show();
                      return;
                    }
                    isNonVeg = true;
                  } else {
                    isNonVeg = false;
                  }
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            SizedBox(height: Get.height / 30),
            CustomButton(
                constants: constants,
                title: 'Add Dish',
                onTap: () {
                  menuController.addDish(
                      dishController.text.toString(),
                      priceController.text.toString(),
                      isVeg == true ? 'Veg' : 'Non-Veg');

                  setState(() {
                    isValueAdded = true;
                  });
                },
                width: Get.width / 5,
                height: Get.height / 20),
            SizedBox(height: Get.height / 20),
            isValueAdded
                ? Obx(() => FutureBuilder(
                      // future: menuController.getAllDishes(),
                      builder: (context, snapshot) {
                        return ListView.builder(
                            itemCount: menuController.totalDishes.toInt(),
                            itemBuilder: (snapshot, index) {
                              return Container();
                            });
                      },
                    ))
                : const Center(
                    child: Text(
                      'Add Dishes to see them here.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
