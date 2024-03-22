import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BagCubit extends Cubit<List<String>> {
  BagCubit(String userUID) : super([]) {
    bagDoc = FirebaseFirestore.instance.collection('users').doc(userUID);

    bagDoc.snapshots().listen((event) {
      List cartArray = event.data()?['cart'] ?? [];
      emit([...cartArray]);
    });
  }

  late DocumentReference<Map<String, dynamic>> bagDoc;

  void addRemoveProductToBag(String productID) {
    bagDoc.update({
      'cart': state.contains(productID)
          ? FieldValue.arrayRemove([productID])
          : FieldValue.arrayUnion([productID])
    });
  }
}
