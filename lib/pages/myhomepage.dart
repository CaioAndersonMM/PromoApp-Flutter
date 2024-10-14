import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meu_app/controllers/comida_controller.dart';
import 'package:meu_app/controllers/evento_controller.dart';
import 'package:meu_app/controllers/my_home_page_controller.dart';
import 'package:meu_app/controllers/produto_controller.dart';
import 'package:meu_app/pages/desejosPage.dart';
import 'package:meu_app/pages/inicioPage.dart';
import 'package:meu_app/pages/interessesPage.dart';
import 'package:meu_app/pages/produtosPage.dart';
import 'package:meu_app/widgets/menu_cidades.dart';
import 'package:path_provider/path_provider.dart';
import 'package:meu_app/models/product_item.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final MyHomePageController controller = Get.put(MyHomePageController());
  final ProdutosController controllerProduto = Get.put(ProdutosController());
  final ComidasController controllerComida = Get.put(ComidasController());
  final EventosController controllerEvento = Get.put(EventosController());

  final List<Widget> _pages = [
    InicioPage(),
    const ProdutosPage(),
    const DesejosPage(),
    InteressesPage(),
  ];

  Future<void> showProductForm(String imageUrl) async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController locationController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    String selectedType = 'Produto';

    await showDialog<void>(
      context: Get.context!,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height * 0.7,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const Text(
                              'Adicionar Produto',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            if (imageUrl.isNotEmpty)
                              Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: FileImage(File(imageUrl)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 20),
                            _buildTextField(nameController, 'Nome do Produto'),
                            _buildTextField(
                                locationController, 'Estabelecimento'),
                            _buildTextField(priceController, 'Preço',
                                keyboardType: TextInputType.number),
                            _buildTextField(descriptionController, 'Descrição'),
                            _buildDropdownButton(selectedType, setState),
                            const SizedBox(height: 20),
                            _buildDialogActions(
                                context,
                                nameController,
                                locationController,
                                priceController,
                                descriptionController,
                                selectedType,
                                imageUrl),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  TextField _buildTextField(TextEditingController controller, String labelText,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      keyboardType: keyboardType,
    );
  }

  DropdownButton<String> _buildDropdownButton(
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

  Row _buildDialogActions(
      BuildContext context,
      TextEditingController nameController,
      TextEditingController locationController,
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
              location: locationController.text,
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

  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String appPath = appDir.path;
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final String newFilePath = '$appPath/$fileName.png';

      final File savedImage = await File(pickedFile.path).copy(newFilePath);

      controller.imagePath.value = savedImage.path;
      Get.snackbar(
        'Foto Capturada',
        'A imagem foi salva com sucesso!',
        backgroundColor: const Color.fromARGB(255, 3, 41, 117),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
      );

      await showProductForm(savedImage.path);
    } else {
      Get.snackbar(
        'Erro',
        'Nenhuma imagem foi capturada.',
        backgroundColor: const Color.fromARGB(255, 3, 41, 117),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: MenuCidades(
        onCitySelected: (newCity) {
          controller.updateSelectedCity(newCity);
        },
      ),
      body: Obx(() {
        return Stack(
          children: [
            Container(
              color: const Color.fromRGBO(0, 12, 36, 1),
              child: IndexedStack(
                index: controller.selectedIndex.value,
                children: _pages,
              ),
            ),
            if (controller.isLoading.value)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        );
      }),
      bottomNavigationBar: Obx(() => _buildBottomNavigationBar()),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
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
                                Text(
                                    '13:55 - Desconto em eletrônico na Amazon'),
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
                  Get.toNamed('/userProfile',
                      arguments: controller.dadosUsuario);
                },
              ),
            ],
          );
        }),
      ],
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
        BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline), label: 'Publicar'),
        BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in_outlined), label: 'Salvos'),
        BottomNavigationBarItem(
            icon: Icon(Icons.saved_search), label: 'Interesses'),
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
            await _pickImageFromCamera();
            controller.isLoading.value = false;
          } else {
            controller.selectedIndex.value = index;
          }
        }
      },
    );
  }
}
