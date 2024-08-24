import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meu_app/pages/user_profile.dart';
import 'package:meu_app/widgets/caixa_pesquisa.dart';
import 'package:meu_app/widgets/header_products.dart';
import 'package:meu_app/widgets/menu_cidades.dart';
import 'package:meu_app/widgets/product_grid.dart';
import 'package:meu_app/widgets/type_item.dart';
import 'pages/comidasPage.dart';
import 'pages/produtosPage.dart';
import 'pages/eventosPage.dart';
import 'controllers/my_home_page_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        GetPage(
            name: '/userProfile',
            page: () => UserProfilePage(
                dadosUsuario: {})), // Ajuste conforme necessário
        // Adicione outras rotas conforme necessário
      ],
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final MyHomePageController controller = Get.put(MyHomePageController());

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
        child: SingleChildScrollView(
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
              const Wrap(
                spacing: 20.0,
                runSpacing: 10.0,
                children: <Widget>[
                  TypeItem(name: 'Comidas', destinationPage: ComidasPage()),
                  TypeItem(name: 'Produtos', destinationPage: ProdutosPage()),
                  TypeItem(name: 'Eventos', destinationPage: EventosPage()),
                  // Adicione mais itens conforme necessário
                ],
              ),
              const SizedBox(height: 25),
              caixaPesquisa('Pesquisar produtos, lojas, promoções...'),
              const SizedBox(height: 5),
              headerProducts(),
              productGrid(context),
            ],
          ),
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
                icon: Icon(Icons.shopping_basket),
                label: 'Desejos',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline),
                label: 'Publicar',
              ),
            ],
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: Color.fromARGB(255, 3, 26, 102),
            onTap: (index) {
              if (controller.selectedCity.value == 'Selecione uma cidade') {
                controller.showCitySelectionAlert();
              } else {
                controller.selectedIndex.value = index;
                if (index == 0) {
                  Get.offNamed('/home');
                } else if (index == 1) {
                  // Navegar para a página de produtos
                } else if (index == 2) {
                  // Navegar para a página de publicação
                }
              }
            },
          )),
    );
  }
}
