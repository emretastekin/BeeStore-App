import 'package:bee_store/cubits/bag_cubit.dart';
import 'package:bee_store/pages/login_page.dart';
import 'package:bee_store/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (_, snapshot) {
          final isLogin = snapshot.hasData && snapshot.data != null;

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: isLogin
                ? BlocProvider(
                    create: (_) => BagCubit(snapshot.data!.uid),
                    child: const MyApp())
                : const LoginPage(),
          );
        });
  }
}
