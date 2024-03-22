import 'package:bee_store/cubits/bag_cubit.dart';
import 'package:bee_store/pages/bag_page.dart';
import 'package:bee_store/pages/loading_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BagButtonWidget extends StatelessWidget {
  const BagButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Stack(
          children: [
            Image.asset(
              "entities/images/bag.png",
              width: 50.5,
              height: 50.5,
            ),
            Positioned.fill(
              child: BlocBuilder<BagCubit, List<String>>(builder: (_, bag) {
                if (bag.isEmpty) return const SizedBox();

                return Align(
                  alignment: Alignment.topRight,
                  child: ColoredBox(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(1.5),
                        child: Text(
                          "${bag.length}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      )),
                );
              }),
            )
          ],
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<BagCubit>(context),
                  child: BagPage(),
                ),
              ));
        });
  }
}
