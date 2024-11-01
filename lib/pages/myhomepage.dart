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
import 'package:meu_app/widgets/custom_widgets.dart';
import 'package:path_provider/path_provider.dart';

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
    final TextEditingController storeController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    String selectedType = 'Produto';
    String selectedLocation = controller.selectedCity.value;

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
                            buildTextField(nameController, 'Nome do Produto'),
                            const SizedBox(height: 10),

                            // Substituição pelo DropdownButton
                            DropdownButtonFormField<String>(
                              value: selectedLocation,
                              items: [
                                DropdownMenuItem(
                                  value: controller.selectedCity.value,
                                  child: Obx(() => Text(controller.selectedCity.value)),
                                ),
                                const DropdownMenuItem(
                                  value: 'Internet',
                                  child: Text('Internet'),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedLocation = value!;
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Origem do Produto',
                                border: OutlineInputBorder(),
                              ),
                            ),

                            const SizedBox(height: 10),
                            buildTextField(storeController, 'Loja'),
                            buildTextField(priceController, 'Preço', keyboardType: TextInputType.number),
                            buildTextField(descriptionController, 'Descrição'),
                            buildDropdownButton(selectedType, setState),
                            const SizedBox(height: 20),
                            buildDialogActions(
                              context,
                              controller,
                              controllerProduto,
                              controllerComida,
                              controllerEvento,
                              nameController,
                              selectedLocation,
                              storeController,
                              priceController,
                              descriptionController,
                              selectedType,
                              imageUrl,
                            ),
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
      appBar: buildAppBar(context, controller),
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
      bottomNavigationBar: Obx(() => buildBottomNavigationBar(controller, _pickImageFromCamera)),
    );
  }
}