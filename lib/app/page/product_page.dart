import 'package:app_good_taste/app/controller/flavor_controller.dart';
import 'package:app_good_taste/app/controller/product_controller.dart';
import 'package:app_good_taste/app/page/product_form_page.dart';
import 'package:app_good_taste/app/template/flavor_list.dart';
import 'package:flutter/material.dart';
import 'package:app_good_taste/app/template/product_list.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Map<String, dynamic>> products = [];
  List<bool> cardTriggeredList = [];
  List<Map<String, dynamic>> flavors = [];
  int triggeredCardIndex = -1; // indíce do carro acionado
  bool expandeCard = false;

  @override
  void initState() {
    super.initState();
    loadProducts();
    loadFlavors();
  }

  void setListCardTriggered() {
    for (int i = 0; i < products.length; i++) {
      setState(() {
        cardTriggeredList.add(false);
      });
    }
  }

  void updateListCardTriggered(int index) {
    setState(() {
      cardTriggeredList[index] = expandeCard;
    });
  }

  Future<void> loadProducts() async {
    final productProvider =
        Provider.of<ProductController>(context, listen: false);
    await productProvider.loadProducts();
    setState(() {
      products = productProvider.items;
      setListCardTriggered();
    });
  }

  Future<void> loadFlavors() async {
    final flavorsProvider =
        Provider.of<FlavorController>(context, listen: false);
    await flavorsProvider.loadFlavors();
    setState(() {
      flavors = flavorsProvider.items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () async {
                final isSaved = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductFormPage(),
                  ),
                );

                if (isSaved == true) {
                  await loadProducts();
                }
              },
              icon: const Icon(
                Icons.add,
                size: 40,
              ),
            ),
          ),
        ],
        title: const Text(
          "Gerenciar Produtos",
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: 100,
      ),
      body: products.isNotEmpty
          ? ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    itemCount: products.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: [
                                  ProductList(products[index],
                                      toggleCard: (expanded) {
                                    setState(() {
                                      expandeCard = expanded;
                                      updateListCardTriggered(index);
                                    });
                                  }),
                                  const SizedBox(height: 5),
                                  FlavorList(
                                    flavors: flavors,
                                    product: products[index],
                                    isExpanded: cardTriggeredList[index],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            )
          : Center(
              child: Text(
                "Não há produto cadastrado.",
                style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.displayLarge!.fontSize),
              ),
            ),
    );
  }
}
