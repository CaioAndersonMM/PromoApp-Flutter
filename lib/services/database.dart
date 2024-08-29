import 'package:meu_app/models/product_item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      String path = join(await getDatabasesPath(), 'products.db');
      return await openDatabase(
        path,
        version: 2, //Todo atualizar a versão do banco de dados sempre que houver mudanças na estrutura
        onCreate: _onCreate,
        onUpgrade: _onUpgrade, // Adicione o método onUpgrade

      );
    } catch (e) {
      print('Erro ao inicializar o banco de dados: $e');
      rethrow;
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
  // Lida com as atualizações da estrutura do banco de dados
  if (oldVersion < 2) {

    //Já passou aqui

    // await db.execute('''
    //   CREATE TABLE desejo(
    //     id INTEGER PRIMARY KEY AUTOINCREMENT,
    //     userId INTEGER NOT NULL,
    //     productId INTEGER NOT NULL,
    //     FOREIGN KEY (productId) REFERENCES products(id)
    //   )
    // ''');
  }
}

  Future<void> clearDatabase() async {
    try {
      Database db = await database;
      // Excluir todas as tabelas
      await db.execute('DROP TABLE IF EXISTS products');
      // Criar as tabelas novamente
      await _onCreate(db, 1);
    } catch (e) {
      print('Erro ao limpar o banco de dados: $e');
      rethrow;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        price REAL,
        imageUrl TEXT,
        location TEXT,
        type TEXT
      )
    ''');

    // Criação da tabela desejo apenas no método _onCreate
    await db.execute('''
      CREATE TABLE desejo(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,
        productId INTEGER NOT NULL,
        FOREIGN KEY (productId) REFERENCES products(id)
      )
    ''');
  }

  Future<int> insertProduct(ProductItem product) async {
    try {
      Database db = await database;
      return await db.insert('products', product.toMap());
    } catch (e) {
      print('Erro ao inserir produto: $e');
      rethrow;
    }
  }

  Future<List<ProductItem>> getProducts() async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> maps = await db.query('products');
      return List.generate(maps.length, (i) {
        return ProductItem.fromMap(maps[i]);
      });
    } catch (e) {
      print('Erro ao buscar produtos: $e');
      rethrow;
    }
  }

  Future<void> inserirDesejo(int userId, int productId) async {
    final db = await database;
    await db.insert('desejo', {
      'userId': userId,
      'productId': productId,
    });
  }

  Future<List<ProductItem>> getDesejos(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'desejo',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    List<ProductItem> desejos = [];
    for (var map in maps) {
      final product = await getProductById(map['productId']);
      desejos.add(product);
    }
    return desejos;
  }

  Future<ProductItem> getProductById(int id) async {
    final db = await database;
    final maps = await db.query('products', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return ProductItem.fromMap(maps.first);
    } else {
      throw Exception('Produto não encontrado');
    }
  }
}
