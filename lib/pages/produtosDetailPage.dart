import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meu_app/services/likes.dart';
import 'package:meu_app/services/auth.dart';
import 'package:meu_app/services/countProductRate.dart';
import 'package:meu_app/services/review.dart';
import 'package:meu_app/widgets/product_widget.dart';
import '../models/product_item.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductItem product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late Future<List<Map<String, dynamic>>> _reviewsFuture;
  final LikesService likesService = Get.put(LikesService());

  @override
  void initState() {
    super.initState();
    _loadReviews();
    _loadLikesAndDislikes();
  }

  void _loadReviews() {
    setState(() {
      _reviewsFuture = ReviewService().obterAvaliacoes(widget.product.id ?? '');
    });
  }

  void _loadLikesAndDislikes() {
    likesService.inicializarContagem(widget.product.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final String userId = AuthService().getUserId();
    var productId = widget.product.id ?? 'erro';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                _getProductImage(widget.product),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 50,
                            height: 40,
                            child: FloatingActionButton(
                              onPressed: () {
                                _showReportDialog(context);
                              },
                              backgroundColor: const Color.fromARGB(255, 94, 10, 5),
                              child: const Icon(Icons.report, color: Colors.white, size: 20),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 94, 10, 5),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Text(
                              'Reportar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(width: 5.0),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 50,
                            height: 40,
                            child: FloatingActionButton(
                              onPressed: () {
                                _salvarProdutoNaSacola();
                              },
                              backgroundColor: const Color.fromARGB(255, 17, 1, 32),
                              child: const Icon(Icons.shopping_bag_rounded, color: Color.fromARGB(255, 253, 253, 253), size: 20),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 17, 1, 32),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Text(
                              'Salvar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: Obx(() {
                              return FloatingActionButton(
                                onPressed: () {},
                                backgroundColor: const Color.fromARGB(255, 145, 3, 3),
                                child: Text('${likesService.quantidadeDislikes.value}', style: const TextStyle(color: Colors.white, fontSize: 20)),
                              );
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(width: 5.0),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: Obx(() {
                              return FloatingActionButton(
                                onPressed: () {},
                                backgroundColor: const Color.fromARGB(255, 22, 1, 160),
                                child: Text('${likesService.quantidadeLikes.value}', style: const TextStyle(color: Colors.white, fontSize: 20)),
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(118, 3, 13, 196),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double fontSizeType = 15.0;

                      if (widget.product.name.length > 10) {
                        fontSizeType = 14.0;
                      }

                      return Text(
                        widget.product.type,
                        style: TextStyle(
                          fontSize: fontSizeType,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double fontSizeName = widget.product.name.length > 10 ? 17.0 : 22.0;
                      return Text(
                        widget.product.name,
                        style: TextStyle(
                          fontSize: fontSizeName,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    likesService.adicionarDislike(productId, userId);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.thumb_down,
                        color: Color.fromARGB(255, 230, 1, 1),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5.0),
                ElevatedButton(
                  onPressed: () {
                    likesService.adicionarLike(productId, userId);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 251, 251, 251),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        color: Color.fromARGB(255, 0, 41, 246),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              'Localização: ${widget.product.location}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Preço: R\$ ${widget.product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 22,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 15, 0, 66),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8.0,
                    spreadRadius: 2.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.product.description ?? 'Descrição do produto não disponível',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Text(
                  'AVALIAÇÕES',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () {
                    _showAddReviewDialog(context);
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'Avaliar',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 5, 20, 94),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            _buildReviewList(),
          ],
        ),
      ),
    );
  }


  Widget _buildReviewList() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _reviewsFuture,
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Erro ao carregar avaliações: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Text(
                'Nenhuma avaliação disponível.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        List<Map<String, dynamic>> reviews = snapshot.data!;

        return Column(
          children: reviews.map((review) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review['name'] ?? 'Usuário desconhecido',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Text(
                          review['review'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Row(
                        children:
                            List.generate(review['rating'].toInt(), (index) {
                          return const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 20,
                          );
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  void _showAddReviewDialog(BuildContext context) {
    final TextEditingController reviewController = TextEditingController();
    final CountProductRatingService pts = CountProductRatingService();
    final ReviewService rvServ = ReviewService();
    final String userId = AuthService().getUserId();
    final String name = AuthService().getUserName();
    var productId = widget.product.id ?? 'erro';

    int selectedStars = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Adicionar avaliação"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Quantas estrelas você dá para este produto?"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          size: 30,
                          index < selectedStars
                              ? Icons.star
                              : Icons.star_border,
                          color: const Color.fromARGB(255, 172, 156, 13),
                        ),
                        onPressed: () {
                          setState(() {
                            selectedStars = index + 1;
                          });
                        },
                      );
                    }),
                  ),
                  TextField(
                    controller: reviewController,
                    decoration: const InputDecoration(
                      labelText: 'Escreva sua avaliação',
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () {
                    if (selectedStars > 0) {
                      pts.adicionarAvaliacao(userId);
                      rvServ.salvarAvaliacao(productId, reviewController.text, selectedStars.toDouble(), name);

                      Get.snackbar(
                        'Avaliação feita',
                        'Obrigado! Outros usuários poderão ver sua avaliação.',
                        backgroundColor: const Color.fromARGB(255, 3, 41, 117),
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                        borderRadius: 10,
                        margin: const EdgeInsets.all(10),
                      );

                      _loadReviews(); // Recarrega as avaliações para atualizar a interface
                      Navigator.of(context).pop();
                    } else {
                      Get.snackbar(
                        'Erro',
                        'Por favor, selecione uma avaliação.',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                        borderRadius: 10,
                        margin: const EdgeInsets.all(10),
                      );
                    }
                  },
                  child: const Text("Adicionar"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showReportDialog(BuildContext context) {
    final TextEditingController _reportReasonController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Reportar Produto"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Deseja realmente reportar este produto?"),
              const SizedBox(height: 10),
              TextField(
                controller: _reportReasonController,
                decoration: const InputDecoration(
                  hintText: "Explique o motivo do reporte",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Get.snackbar(
                  'Reporte feito',
                  'Moderadores irão verificar e tomar as devidas providências.',
                  backgroundColor: const Color.fromARGB(255, 73, 3, 3),
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                  borderRadius: 10,
                  margin: const EdgeInsets.all(10),
                );
                String reportReason = _reportReasonController.text;
                // Adicione a lógica para lidar com o motivo do reporte aqui
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: const Text("Reportar"),
            ),
          ],
        );
      },
    );
  }

  Widget _getProductImage(ProductItem product) {
    // Determina a URL da imagem com base no tipo do produto
    String imageUrl;
    if (product.type == 'Produto') {
      imageUrl =
          'https://radio93fm.com.br/wp-content/uploads/2019/02/produto.png';
    } else if (product.type == 'Comida') {
      imageUrl =
          'https://img.freepik.com/vetores-premium/ilustracao-colorida-de-desenhos-animados-de-comida_1305385-66378.jpg';
    } else if (product.type == 'Evento') {
      imageUrl =
          'https://thumbs.dreamstime.com/b/no-show-isolado-ilustra%C3%A7%C3%B5es-do-vetor-de-desenho-animado-grupo-amigos-sorridentes-se-divertem-concerto-evento-grandioso-festival-256583009.jpg';
    } else {
      imageUrl =
          'https://radio93fm.com.br/wp-content/uploads/2019/02/produto.png'; // Imagem padrão
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: SizedBox(
        width: double.infinity,
        height: 250,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Exibe uma imagem genérica de fallback dependendo do tipo de produto
            String fallbackImage;
            if (product.type == 'Produto') {
              fallbackImage = 'assets/images/generic_product.png';
            } else if (product.type == 'Comida') {
              fallbackImage = 'assets/images/generic_food.png';
            } else if (product.type == 'Evento') {
              fallbackImage = 'assets/images/generic_event.png';
            } else {
              fallbackImage = 'assets/images/generic_default.png';
            }

            return Image.asset(
              fallbackImage,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }

  void _salvarProdutoNaSacola() {
    var productWidget = ProductWidget(product: widget.product);
    productWidget.toggleFavoriteStatus();
  }
}
