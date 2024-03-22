import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Kalan süre değişkeni
  // PageView controller değişkeni
  final PageController controller = PageController(initialPage: 0);
  // PageView'in bulunduğu sayfayı kontrol için değişken
  int currentPage = 0;
  // Slider noktaları
  late Color dot1 = Color.fromRGBO(29, 78, 216, 1);
  late Color dot2 = Colors.red;
  late Color dot3 = Colors.yellow;
  late Color dot4 = Colors.green;
  late Color dot5 = Colors.purple;
  // Slider otomatik kayması için sayaç
  int sayac = 0;

  @override
  void initState() {
    super.initState();

    // Sayfa değiştiği andaki işlemler
    controller.addListener(() {
      setState(() {
        currentPage = controller.page?.round() ?? 0;
        switch (currentPage) {
          case 0:
            dot1 = Color.fromRGBO(29, 78, 216, 1);
            dot2 = Colors.grey;
            dot3 = Colors.grey;
            dot4 = Colors.grey;
            dot5 = Colors.grey;
            break;
          case 1:
            dot1 = Colors.grey;
            dot2 = Color.fromRGBO(29, 78, 216, 1);
            dot3 = Colors.grey;
            dot4 = Colors.grey;
            dot5 = Colors.grey;
            break;
          case 2:
            dot1 = Colors.grey;
            dot2 = Colors.grey;
            dot3 = Color.fromRGBO(29, 78, 216, 1);
            dot4 = Colors.grey;
            dot5 = Colors.grey;
            break;
          case 3:
            dot1 = Colors.grey;
            dot2 = Colors.grey;
            dot3 = Colors.grey;
            dot4 = Color.fromRGBO(29, 78, 216, 1);
            dot5 = Colors.grey;
            break;
          case 4:
            dot1 = Colors.grey;
            dot2 = Colors.grey;
            dot3 = Colors.grey;
            dot4 = Colors.grey;
            dot5 = Color.fromRGBO(29, 78, 216, 1);
            break;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          // Boş bir appBar ekleyerek üstteki boşluğu kaldırın
          toolbarHeight: 0, // appBar'ın yüksekliğini sıfıra ayarlar
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.topCenter,
                width:
                    MediaQuery.of(context).size.width, // Cihaz genişliği kadar
                height: MediaQuery.of(context).size.height *
                    0.8, // Cihaz yüksekliğinin %80'i kadar
                child: PageView(
                  controller: controller,
                  children: <Widget>[
                    Center(
                      child: Image.asset("entities/images/Calvin2.png"),
                    ),
                    Center(
                      child: Image.asset("entities/images/Slider7.png"),
                    ),
                    Center(
                      child: Image.asset("entities/images/Slider8.png"),
                    ),
                    Center(
                      child: Image.asset("entities/images/Slider9.png"),
                    ),
                    Center(
                      child: Image.asset("entities/images/Calvin2.png"),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.circle,
                      size: 6,
                      color: dot1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.circle,
                      size: 6,
                      color: dot2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.circle,
                      size: 6,
                      color: dot3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.circle,
                      size: 6,
                      color: dot4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.circle,
                      size: 6,
                      color: dot5,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Calvin Clein',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Text(
                "Calvin Clein Regular fit slim shirt",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "entities/images/RatingChip.png",
                      width: 60,
                    ),
                    SizedBox(width: 10),
                    Text("87 Reviews"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  children: [
                    Text(
                      "\$35",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10), // Metinler arasında yatay boşluk
                    Text(
                      "\$40.25",
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 15,
                          color: Colors.grey),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "15% OFF",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  children: [
                    Text(
                      "Color:",
                      style: TextStyle(fontSize: 25, color: Colors.grey),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "White",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      "Only 5 Left",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Center(
                        child: Image.asset(
                          "entities/images/ProductImages.png",
                          width: 500,
                          height: 95,
                        ),
                      ),
                    ),
                  ),
                  // Diğer widget'ler
                ],
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  children: [
                    Text(
                      "Size",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 138,
                    ),
                    Text(
                      "Size Chart",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  children: [
                    Image.asset(
                      "entities/images/SizeSelectors.png",
                      width: 300,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
