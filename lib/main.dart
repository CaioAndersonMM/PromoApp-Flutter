import 'package:flutter/material.dart';
import 'package:meu_app/widgets/product_item.dart';
import 'package:meu_app/widgets/type_item.dart';
import 'pages/comidasPage.dart';
import 'pages/produtosPage.dart';
import 'pages/eventosPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            // Envolva o Column com SingleChildScrollView
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          labelText: 'Pesquisar',
                          labelStyle: TextStyle(color: Colors.white),
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
                          backgroundColor:
                              const Color.fromARGB(255, 29, 48, 82),
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
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 180, // Ajuste a altura conforme necessário
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
      ),
    );
  }
}

Widget _buildSectionHeader(String leftText, String rightText) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10, top: 10),
    color: const Color.fromRGBO(0, 87, 255, 1),
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            leftText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const Spacer(),
        Container(
          alignment: Alignment.bottomRight,
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            rightText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
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
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
