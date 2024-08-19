import 'package:flutter/material.dart';
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
                Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                  color: const Color.fromRGBO(0, 87, 255, 1),
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: const Text(
                          'Produtos (-) Preço',
                          style: TextStyle(
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
                        child: const Text(
                          'Categorias (-) Todos',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 300, // Ajusta altura de visualização de produtos
                  child: GridView.builder(
                    itemCount: 6,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Dois produtos por linha
                      crossAxisSpacing:
                          2.0, //Espaçamento entre os produtos lateral
                      mainAxisSpacing:
                          10.0, // Espaçamento entre os produtos vertical
                      childAspectRatio:
                          3 / 2, // Proporção da altura dos produtos
                    ),
                    itemBuilder: (context, index) {
                      return ProductItem(
                        name: 'Produto ${index + 1}',
                        imageUrl: 'https://via.placeholder.com/50',
                        location: 'Loja ${String.fromCharCode(65 + index)}',
                        price: 19.99 + (index * 10),
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 20),
                  color: const Color.fromRGBO(0, 87, 255, 1),
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: const Text(
                          'Produtos (-) Preço',
                          style: TextStyle(
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
                        child: const Text(
                          'Categorias (-) Todos',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 300, // Ajusta altura de vizualização de produtos
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Wrap(
                          spacing: 10.0,
                          runSpacing: 10.0,
                          children: <Widget>[
                            ProductItem(
                              name: 'Produto 1',
                              imageUrl: 'https://via.placeholder.com/50',
                              location: 'Loja A',
                              price: 19.99,
                            ),
                            ProductItem(
                              name: 'Produto 2',
                              imageUrl: 'https://via.placeholder.com/50',
                              location: 'Loja B',
                              price: 29.99,
                            ),
                            ProductItem(
                              name: 'Produto 3',
                              imageUrl: 'https://via.placeholder.com/50',
                              location: 'Loja C',
                              price: 39.99,
                            ),
                            ProductItem(
                              name: 'Produto 4',
                              imageUrl: 'https://via.placeholder.com/50',
                              location: 'Loja D',
                              price: 49.99,
                            ),
                            ProductItem(
                              name: 'Produto 5',
                              imageUrl: 'https://via.placeholder.com/50',
                              location: 'Loja E',
                              price: 59.99,
                            ),
                            ProductItem(
                              name: 'Produto 6',
                              imageUrl: 'https://via.placeholder.com/50',
                              location: 'Loja F',
                              price: 69.99,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
      ),
    );
  }
}

class BaseItem extends StatelessWidget {
  final String name;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double borderRadius;

  const BaseItem({
    super.key,
    required this.name,
    required this.padding,
    this.margin = EdgeInsets.zero,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: _containerDecoration(),
      child: Text(
        name,
        style: _textStyle(),
        textAlign: TextAlign.center,
      ),
    );
  }

  BoxDecoration _containerDecoration() {
    // Style para diminuir do Builder
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  TextStyle _textStyle() {
    return const TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
  }
}

class ProductItem extends BaseItem {
  final String imageUrl;
  final String location;
  final double price;

  const ProductItem({
    super.key,
    required String name,
    required this.imageUrl,
    required this.location,
    required this.price,
  }) : super(name: name, padding: const EdgeInsets.all(26));

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: _containerDecoration(),
      child: Row(
        children: [
          Image.network(
            imageUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: _textStyle(),
              ),
              const SizedBox(height: 5),
              Text(
                location,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 5),
              Text(
                'R\$ ${price.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 14, color: Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TypeItem extends BaseItem {
  final Widget destinationPage;
  const TypeItem(
      {super.key, required String name, required this.destinationPage})
      : super(
          name: name,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(bottom: 10, top: 20),
          borderRadius: 2,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      child:  Container(
      margin: margin,
      padding: padding,
      decoration: _containerDecoration(),
      child: Text(
        name,
        style: _textStyle(),
        textAlign: TextAlign.center,
      ),
    )
    );
  }
}

class ProductList extends StatelessWidget {
  final List<ProductItem> products;

  const ProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150, // Defina a altura adequada para os itens do produto
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: products,
      ),
    );
  }
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
