class ProductModel {
  final String uid;
  final String title;
  final String imagePath;
  final int usdPrice;
  final double discountRate;

  const ProductModel(
      {required this.uid,
      required this.title,
      required this.imagePath,
      required this.usdPrice,
      required this.discountRate});

  factory ProductModel.fromFirestore(Map map, String uid) {
    return ProductModel(
        uid: uid,
        title: map['title'],
        imagePath: map['imagePath'],
        usdPrice: map['usdPrice'],
        discountRate: map['discountRate']);
  }
}
