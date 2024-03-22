import 'dart:math';

import 'package:bee_store/cubits/bag_cubit.dart';
import 'package:bee_store/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BagPage extends StatelessWidget {
  const BagPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Bag")),
      body: BlocBuilder<BagCubit, List<String>>(
        builder: (_, state) {
          if (state.isEmpty) {
            return const Center(
                child: Text("Your bag is empty",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)));
          }

          final totalBagAmountNotifier = ValueNotifier(0.0);

          return Column(
            children: [
              Expanded(
                  child: ListView(
                children: [
                  for (final productID in state)
                    FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('products')
                            .doc(productID)
                            .get(),
                        builder: (_, snapshot) {
                          if (snapshot.hasData) {
                            final product = ProductModel.fromFirestore(
                                snapshot.data!.data()!, snapshot.data!.id);
                            final discountedPrice = product.usdPrice -
                                product.usdPrice * product.discountRate;

                            Future.delayed(Duration(
                                    milliseconds: Random().nextInt(150)))
                                .whenComplete(() => totalBagAmountNotifier
                                    .value += discountedPrice);

                            return Card(
                                child: ListTile(
                              title: Text(product.title),
                              subtitle: Row(
                                children: [
                                  Text("\$${product.usdPrice}"),
                                  const VerticalDivider(),
                                  Text(
                                      "Discounted price: \$${discountedPrice.toStringAsFixed(2)}"),
                                ],
                              ),
                            ));
                          }
                          return const LinearProgressIndicator();
                        }),
                ],
              )),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Total bag amount: ",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold),
                            ),
                            ValueListenableBuilder(
                                valueListenable: totalBagAmountNotifier,
                                builder: (_, amount, __) {
                                  return Text(
                                    "\$${amount.toStringAsFixed(2)}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  );
                                }),
                          ],
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {},
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.blue)),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "Proceed to payment",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
