import 'package:flutter/material.dart';
import 'package:meu_app/pages/user_profile.dart';
import 'package:meu_app/widgets/product_item.dart';
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedCity = 'Selecione uma cidade';
  List<String> cidades = [
    'Mossoró',
    'Natal',
    'Jucurutu',
    'João Pessoa',
    'Campina Grande',
    'Fortaleza',
    'Recife'
  ];

  Map<String, dynamic> dadosUsuario = {
    'userName': 'Bruno',
    'postCount': 5,
    'reviewCount': 15,
    'userLevel': '2',
  };

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        // Navigate to the home page
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MyHomePage(

                  )),
        );
      } else if (index == 1) {
        // Navigate to the products page
      } else if (index == 2) {

        // Navigate to the profile page
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => UserProfilePage(
        //             dadosUsuario: dadosUsuario,
        //             selectedCity: selectedCity,
        //           )),
        // );
      }
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
                    builder: (context) => UserProfilePage(dadosUsuario: dadosUsuario, selectedCity: selectedCity,)),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              child: Text(
                'Escolha uma cidade para ver as promoções',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ...cidades.map((cidade) {
              return ListTile(
                // Cria um item de lista para cada cidade
                leading: const Icon(Icons.location_city),
                title: Text(cidade),
                onTap: () {
                  setState(() {
                    selectedCity = cidade;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
            // Adicione mais cidades conforme necessário
          ],
        ),
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
              // _caixaPesquisa('Pesquisar promoções'),
              const SizedBox(height: 15),
              SizedBox(
                height: 150,
                child: PageView(
                  children: <Widget>[
                    Image.network(
                      'https://via.placeholder.com/400x200.png?text=Em+Alta',
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      'https://via.placeholder.com/400x200.png?text=Anuncio',
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      'https://via.placeholder.com/400x200.png?text=Sobre+Nós',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
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
              _buildSectionHeader('Produtos (-) Preço', 'Categorias (-) Todos'),
              _buildProductGrid(),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
      bottomNavigationBar: BottomNavigationBar( //Menu abaixo
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
        onTap: _onItemTapped,
      ),
    );
  }
}

Widget _caixaPesquisa(String placeholder) {
  return Row(
    children: <Widget>[
      Expanded(
        child: TextField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            labelText: placeholder,
            labelStyle: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      const SizedBox(width: 10),
      SizedBox(
        width: 60,
        height: 60,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 29, 48, 82),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildSectionHeader(String leftText, String rightText) {
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
        color: const Color.fromARGB(255, 255, 255, 255),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: DropdownButton<String>(
                  value: selectedSortOption1,
                  items: sortOptions.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSortOption1 = newValue!;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: DropdownButton<String>(
                  value: selectedSortOption2,
                  items: sortOptions2.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSortOption2 = newValue!;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildProductGrid() {
  final List<ProductItem> products = _getProducts();

  return SizedBox(
    height: 300,
    child: GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 2.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 3 / 2,
      ),
      itemBuilder: (context, index) {
        return products[index];
      },
    ),
  );
}

List<ProductItem> _getProducts() {
  return [
    const ProductItem(
      name: 'Produto X',
      imageUrl: 'https://via.placeholder.com/50',
      location: 'Loja A',
      price: 19.99,
    ),
    const ProductItem(
      name: 'Produto 2',
      imageUrl: 'https://via.placeholder.com/50',
      location: 'Loja B',
      price: 29.99,
    ),
    const ProductItem(
      name: 'Produto 3',
      imageUrl: 'https://via.placeholder.com/50',
      location: 'Loja C',
      price: 39.99,
    ),
    const ProductItem(
      name: 'Produto 4',
      imageUrl: 'https://via.placeholder.com/50',
      location: 'Loja D',
      price: 49.99,
    ),
    const ProductItem(
      name: 'Produto 5',
      imageUrl: 'https://via.placeholder.com/50',
      location: 'Loja E',
      price: 59.99,
    ),
    const ProductItem(
      name: 'Produto 6',
      imageUrl: 'https://via.placeholder.com/50',
      location: 'Loja F',
      price: 69.99,
    ),
  ];
}
