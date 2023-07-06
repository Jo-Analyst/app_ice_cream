import 'package:app_good_taste/app/template/balance_sheet_page.dart';
import 'package:flutter/material.dart';
import 'package:app_good_taste/app/template/movement_details_template.dart';

import '../template/slide_month.dart';

class MovementDetailsPage extends StatelessWidget {
  const MovementDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox(
        width: 50,
        height: 50,
        child: FloatingActionButton(
          heroTag: null,
          mini: true,
          onPressed: () {},
          child: const Icon(
            Icons.picture_as_pdf_outlined,
            size: 30,
          ),
        ),
      ),
      appBar: AppBar(
        actions: [],
        title: Align(
          alignment: Alignment.center,
          child: Stack(children: [
            Container(
              width: 250,
              height: 100,
              color: Colors.white,
            ),
            
          ]),
        ),
        toolbarHeight: 150,
      ),
      body: Stack(
        children: [
          const SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                // Container(
                //   height: 150,
                //   width: double.infinity,
                //   color: Theme.of(context).primaryColor,
                //   child: Container(
                //     margin: const EdgeInsets.only(bottom: 20),
                //     child: const Align(
                //       alignment: Alignment.center,
                //       // child: Text(
                //       //   'Bom Paladar',
                //       //   style: TextStyle(
                //       //     fontSize: 35,
                //       //     color: Colors.white,
                //       //     fontWeight: FontWeight.w900,
                //       //   ),
                //       // ),
                //     ),
                //   ),
                // ),
                SizedBox(height: 28),
                SlideMonth(),

                // const SizedBox(height: 5),
                // const SizedBox(height: 20),
                Column(
                  children: [
                    MovementDetailsTemplate(price: 150, description: "Entrada"),
                    MovementDetailsTemplate(price: 50, description: "Saida"),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: AppBar().preferredSize.height,
            left: MediaQuery.of(context).size.width / 2 - 125,
            width: 250,
            child: Card(
              elevation: 6,
              // shadowColor: Theme.of(context).primaryColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Lucro Total',
                      style: TextStyle(fontSize: 18),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'R\$ 650,00',
                          style: TextStyle(
                            fontSize: 30,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: IconButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const BalanceteSheetPage(),
                              ),
                            ),
                            icon: const Icon(
                              Icons.balance,
                              color: Colors.white,
                              // size: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
