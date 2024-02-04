import 'package:flutter/material.dart';

class HomepageProductWidget extends StatefulWidget {
  const HomepageProductWidget(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.usdPrice,
      required this.discountRate,
      required this.imagePath2,
      required this.additionalText,
      required this.firstPrice});

  final String title;
  final String imagePath;
  final double usdPrice;
  final double discountRate;
  final String imagePath2;
  final String additionalText;
  final double firstPrice;

  @override
  State createState() => _HomepageProductWidgetState();
}

/*
String title = "Adidas white sneakers for men";
double usdPrice = 68.5;
bool isFavorite = false;
double discountRate = 50;
String imagePath = "entities/Adidas.png";
*/

class _HomepageProductWidgetState extends State<HomepageProductWidget> {
  @override
  Widget build(BuildContext) {
    return Card(
      child: Column(children: [
        Stack(
          children: [
            Image.asset(
              widget.imagePath,
              width: 148,
              height: 104,
            ),
            Positioned.fill(
              top: -70,
              left: 116,
              child: Center(
                child: Icon(
                  Icons.favorite,
                  color: (widget.title == ("Nike white sneakers for men") ||
                          widget.title ==
                              ("Allen Solly Regular fit cotton shirt"))
                      ? Colors.grey
                      : Colors.red,
                ),
              ),
            ),
          ],
        ),
        Text(widget.title),
        Row(
          children: [
            Text(
              "\$${widget.usdPrice}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              " \$${widget.firstPrice}",
              style: TextStyle(decoration: TextDecoration.lineThrough),
            ),
            Text("  ${widget.discountRate}% OFF",
                style: TextStyle(
                  color: Colors.red,
                )),
          ],
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 50, top: 5),
              child: Image.asset(
                widget.imagePath2,
                width: 16,
                height: 16,
              ),
            ),
            Text(
              widget.additionalText,
              style: TextStyle(fontSize: 14),
            )
          ],
        )
      ]),
    );
  }
}
