import 'package:bee_store/cubits/bag_cubit.dart';
import 'package:bee_store/models/product_model.dart';
import 'package:bee_store/pages/loading_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomepageProductWidget extends StatefulWidget {
  const HomepageProductWidget({super.key, required this.product});

  final ProductModel product;

  @override
  State createState() => _HomepageProductWidgetState();
}

/*
String title = "Adidas white sneakers for men";
double usdPrice = 68.5;
bool isFavorite = false;
double discountRate = 50;
String imagePath = "entities/images/Adidas.png";
*/

class _HomepageProductWidgetState extends State<HomepageProductWidget> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext) {
    final user = FirebaseAuth.instance.currentUser;

    final userDoc =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);
    return Card(
      child: SizedBox(
        width: 180,
        child: Column(children: [
          Stack(
            children: [
              Image.network(
                widget.product.imagePath,
                width: 180,
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        _isFavorite = !_isFavorite;
                        setState(() {});
                      },
                      icon: _isFavorite
                          ? const Icon(Icons.favorite, color: Colors.red)
                          : const Icon(Icons.favorite_border)),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: BlocBuilder<BagCubit, List<String>>(
                    builder: (_, bag) {
                      final inCart = bag.contains(widget.product.uid);
                      return IconButton(
                          onPressed: () {
                            context
                                .read<BagCubit>()
                                .addRemoveProductToBag(widget.product.uid);
                          },
                          icon: inCart
                              ? const Icon(Icons.shopping_bag,
                                  color: Colors.black)
                              : const Icon(Icons.shopping_bag_outlined));
                    },
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              widget.product.title,
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Text(
                "\$${widget.product.usdPrice - (widget.product.usdPrice * widget.product.discountRate)}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Text(
                "\$${widget.product.usdPrice}",
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 8),
              Text("  ${(widget.product.discountRate * 100).toInt()}% OFF",
                  style: const TextStyle(
                    color: Colors.deepOrange,
                  )),
            ],
          ),
          SizedBox(height: 12),
        ]),
      ),
    );
  }
}
