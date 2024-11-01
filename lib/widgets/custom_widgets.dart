import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meu_app/models/product_item.dart';
import 'package:meu_app/controllers/comida_controller.dart';
import 'package:meu_app/controllers/evento_controller.dart';
import 'package:meu_app/controllers/produto_controller.dart';
import 'package:meu_app/controllers/my_home_page_controller.dart';

TextField buildTextField(TextEditingController controller, String labelText,
    {TextInputType keyboardType = TextInputType.text}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
    ),
    keyboardType: keyboardType,
  );
}

DropdownButton<String> buildDropdownButton(
    String selectedType, StateSetter setState) {
  return DropdownButton<String>(
    value: selectedType,
    onChanged: (String? newValue) {
      setState(() {
        selectedType = newValue ?? 'Comida';
      });
    },
    items: <String>['Comida', 'Produto', 'Evento']
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}

Row buildDialogActions(
    BuildContext context,
    MyHomePageController controller,
    ProdutosController controllerProduto,
    ComidasController controllerComida,
    EventosController controllerEvento,
    TextEditingController nameController,
    String locationController,
    TextEditingController storeController,
    TextEditingController priceController,
    TextEditingController descriptionController,
    String selectedType,
    String imageUrl) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Cancelar'),
      ),
      ElevatedButton(
        onPressed: () async {
          controller.isLoading.value = true;
          Navigator.of(context).pop();

          double price = double.tryParse(priceController.text) ?? 0.0;

          ProductItem product = ProductItem(
            name: nameController.text,
            imageUrl: imageUrl,
            location: locationController,
            store: storeController.text,
            price: price,
            type: selectedType,
            description: descriptionController.text,
            rate: null,
          );

          try {
            if (selectedType == 'Comida') {
              await controllerComida.addProduct(product);
            } else if (selectedType == 'Produto') {
              await controllerProduto.addProduct(product);
            } else if (selectedType == 'Evento') {
              await controllerEvento.addEvent(product);
            }
          } catch (e) {
            Get.snackbar(
              'Erro',
              'Falha ao adicionar produto: $e',
              backgroundColor: const Color.fromARGB(255, 61, 2, 2),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              borderRadius: 10,
              margin: const EdgeInsets.all(10),
            );
          } finally {
            controller.isLoading.value = false;
          }
        },
        child: const Text('Adicionar'),
      ),
    ],
  );
}

AppBar buildAppBar(BuildContext context, MyHomePageController controller) {
  return AppBar(
    title: const Text(
      'Promoapp',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color.fromRGBO(0, 12, 36, 1),
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.white,
    actions: [
      Obx(() {
        return Row(
          children: [
            if (controller.selectedIndex.value == 0)
              IconButton(
                icon: const Icon(Icons.message),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Notificações Recentes'),
                        content: const SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('03:00 - Videogame em oferta na Pichau'),
                              Text('10:00 - Promoções de roupas na C&A'),
                              Text('13:55 - Desconto em eletrônico na Amazon'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Fechar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Get.toNamed('/userProfile', arguments: controller.dadosUsuario);
              },
            ),
          ],
        );
      }),
    ],
  );
}

BottomNavigationBar buildBottomNavigationBar(
    MyHomePageController controller, Future<void> Function() pickImageFromCamera) {
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
      BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'Publicar'),
      BottomNavigationBarItem(icon: Icon(Icons.assignment_turned_in_outlined), label: 'Salvos'),
      BottomNavigationBarItem(icon: Icon(Icons.saved_search), label: 'Interesses'),
    ],
    currentIndex: controller.selectedIndex.value,
    selectedItemColor: const Color.fromARGB(255, 3, 26, 102),
    unselectedItemColor: const Color.fromARGB(255, 70, 142, 167),
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedLabelStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 3, 26, 102),
    ),
    unselectedLabelStyle: const TextStyle(
      color: Color.fromARGB(255, 70, 142, 167),
    ),
    onTap: (index) async {
      if (controller.selectedCity.value == 'Selecione uma cidade') {
        controller.showCitySelectionAlert();
      } else {
        if (index == 1) {
          controller.isLoading.value = true;
          await pickImageFromCamera();
          controller.isLoading.value = false;
        } else {
          controller.selectedIndex.value = index;
        }
      }
    },
  );
}