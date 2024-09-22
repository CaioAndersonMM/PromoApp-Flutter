import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meu_app/pages/desejosPage.dart';
import 'package:meu_app/pages/user_profile.dart';
import 'package:meu_app/widgets/caixa_pesquisa.dart';
import 'package:meu_app/widgets/header_products.dart';
import 'package:meu_app/widgets/menu_cidades.dart';
import 'package:meu_app/widgets/type_item.dart';
import 'package:meu_app/widgets/product_widget.dart'; // Certifique-se de importar o ProductWidget
import 'pages/comidasPage.dart';
import 'pages/produtosPage.dart';
import 'pages/eventosPage.dart';
import 'controllers/my_home_page_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(MyHomePageController());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => MyHomePage()),
        GetPage(name: '/userProfile', page: () => const UserProfilePage()),
        GetPage(name: '/desejo', page: () => DesejosPage()),
      ],
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final MyHomePageController controller = Get.put(MyHomePageController());

 Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String appPath = appDir.path;
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final String newFilePath = '$appPath/$fileName.png';

      // Salva a imagem no diretório do app
      final File savedImage = await File(pickedFile.path).copy(newFilePath);

      // Armazena a URL do arquivo salvo no controlador (ou use onde precisar)
      controller.imagePath.value = savedImage.path;

      // Aqui você pode navegar para a página de criação de produto, por exemplo
      Get.snackbar('Foto Capturada', 'A imagem foi salva com sucesso!');
    } else {
      Get.snackbar('Erro', 'Nenhuma imagem foi capturada.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Get.toNamed('/userProfile', arguments: controller.dadosUsuario);
            },
          ),
        ],
      ),
      drawer: MenuCidades(
        onCitySelected: (newCity) {
          controller.updateSelectedCity(newCity);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Obx(() => Text(
                  'Cidade Selecionada: ${controller.selectedCity}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
            const SizedBox(height: 20),
            Wrap(
              spacing: 20.0,
              runSpacing: 10.0,
              children: <Widget>[
                TypeItem(name: 'Comidas', destinationPage: ComidasPage()),
                const TypeItem(
                    name: 'Produtos', destinationPage: ProdutosPage()),
                const TypeItem(name: 'Eventos', destinationPage: EventosPage()),
              ],
            ),
            const SizedBox(height: 25),
            caixaPesquisa('Pesquisar produtos, lojas, promoções...'),
            const SizedBox(height: 5),
            headerProducts(),
            Expanded(
              child: Obx(() {
                if (controller.filteredProducts.isEmpty) {
                  return const Center(
                      child: Text('Nenhum produto disponível',
                          style: TextStyle(color: Colors.white)));
                }

                return SingleChildScrollView(
                  child: Wrap(
                    runSpacing: 10.0,
                    children: controller.filteredProducts.map((product) {
                      return ProductWidget(product: product);
                    }).toList(),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Início',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline),
                label: 'Publicar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket),
                label: 'Desejos',
              ),
            ],
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: const Color.fromARGB(255, 3, 26, 102),
            onTap: (index) async {
              if (controller.selectedCity.value == 'Selecione uma cidade') {
                controller.showCitySelectionAlert();
              } else {
                controller.selectedIndex.value = index;
                if (index == 0) {
                  Get.offNamed('/home');
                } else if (index == 1) {
                  print('Abrindo câmera...');
                  await _pickImageFromCamera();
                } else if (index == 2) {
                  Get.offNamed('/desejo');
                }
              }
            },
          )),
    );
  }
}
