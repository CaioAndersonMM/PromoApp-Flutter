import 'package:flutter/material.dart';
import 'package:meu_app/pages/user_profile.dart';
import 'package:meu_app/widgets/caixa_pesquisa.dart';
import 'package:meu_app/widgets/header_products.dart';
import 'package:meu_app/widgets/menu_cidades.dart';
import 'package:meu_app/widgets/product_grid.dart';
import 'package:meu_app/widgets/type_item.dart';
import 'pages/comidasPage.dart';
import 'pages/produtosPage.dart';
import 'pages/eventosPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(selectedCity: 'Selecione uma cidade'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String selectedCity;
  const MyHomePage({super.key, required this.selectedCity});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String selectedCity;
  
  Map<String, dynamic> dadosUsuario = {
    'city': 'Mossoró',
    'userName': 'Bruno',
    'postCount': 5,
    'reviewCount': 15,
    'userLevel': '2',
  };

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedCity = widget.selectedCity;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        // Navigate to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage(selectedCity: selectedCity)),
        );
      } else if (index == 1) {
        // Navigate to the products page
      } else if (index == 2) {
        // Navigate to the publication page
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => PublicationPage(
        //       dadosUsuario: dadosUsuario,
        //     ),
        //   ),
        // );
      }
    });
  }

  void _showCitySelectionAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleção de Cidade'),
          content: const Text('Por favor, selecione uma cidade no menu esquerdo para continuar.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _updateSelectedCity(String newCity) {
    setState(() {
      selectedCity = newCity;
      dadosUsuario['city'] = newCity; // Atualize a cidade no mapa de dados do usuário
    });
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfilePage(
                    dadosUsuario: dadosUsuario,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      drawer: MenuCidades(
        onCitySelected: (newCity) {
          _updateSelectedCity(newCity);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Text(
                'Cidade Selecionada: $selectedCity',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
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
      bottomNavigationBar: BottomNavigationBar(
        //Menu abaixo
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
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 3, 26, 102),
        onTap: (index) {
          if (selectedCity == 'Selecione uma cidade') {
            _showCitySelectionAlert();
          } else {
            _onItemTapped(index);
          }
        },
      ),
    );
  }
}