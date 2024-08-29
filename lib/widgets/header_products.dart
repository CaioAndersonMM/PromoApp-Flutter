import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meu_app/controllers/my_home_page_controller.dart';

Widget headerProducts() {
  final MyHomePageController controller = Get.find();

  String selectedSortOption1 = 'Mais Baratos';
  String selectedSortOption2 = 'Tudo';

  final List<String> sortOptions = [
    'Mais Baratos',
    'Mais Recentes',
    'Mais Comprados'
  ];

  final List<String> sortOptions2 = ['Tudo', 'Comidas', 'Produtos', 'Eventos'];

  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Container(
        margin: const EdgeInsets.only(bottom: 5, top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    const Icon(
                      Icons.sort,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8.0),
                    DropdownButton<String>(
                      value: selectedSortOption1,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      underline: Container(),
                      items: sortOptions.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                      setState(() {
                          selectedSortOption1 = newValue!;
                          controller.filterAndSortProducts(selectedSortOption1, selectedSortOption2);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.filter_list,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8.0),
                    DropdownButton<String>(
                      value: selectedSortOption2,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      underline: Container(),
                      items: sortOptions2.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                         setState(() {
                          selectedSortOption2 = newValue!;
                          controller.filterAndSortProducts(selectedSortOption1, selectedSortOption2);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
