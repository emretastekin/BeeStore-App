// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'package:bee_store/firebase_options.dart';
import 'package:bee_store/models/product_model.dart';
import 'package:bee_store/parts/app_drawer.dart';
import 'package:bee_store/parts/bag_button_widget.dart';
import 'package:bee_store/parts/category_widget.dart';
import 'package:bee_store/parts/homepage_product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'dart:async';

// Fonksiyon Tanımlamak
Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Kalan süre değişkeni
  late Duration _timeUntilTarget;
  //pageView conterller değişkeni
  final PageController controller = PageController(initialPage: 0);
  //pageView in bulunduğu sayfayı kontol için değişken
  int currentPage = 0;
  //slider noktaları
  late Color dot1 = Color.fromRGBO(29, 78, 216, 1);
  late Color dot2 = Colors.yellow;
  late Color dot3 = Colors.red;
  late Color dot4 = Colors.green;
  late Color dot5 = Colors.purple;
  //Slider otomatik kayması için sayaç
  int sayac = 0;

  @override
  void initState() {
    super.initState();

    //Hedef an
    DateTime targetDate = DateTime(2024, 1, 30, 11);

    //Tekrar dedin sayaç(zamana bağlı işlemler için)
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        int nextPage = (controller.page?.round() ?? 0) + 1;
        if (nextPage > 4) {
          nextPage = 0;
        }
        if (sayac == 8) {
          controller.animateToPage(nextPage,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
          sayac = 0;
        }
        sayac++;
        _timeUntilTarget = DateTime.now().difference(targetDate);
      });
    });

    //Hedef ana kalan sürenin hesaplandığı yer
    setState(() {
      _timeUntilTarget = DateTime.now().difference(targetDate);
    });

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
          case 1:
            dot1 = Colors.grey;
            dot2 = Color.fromRGBO(29, 78, 216, 1);
            dot3 = Colors.grey;
            dot4 = Colors.grey;
            dot5 = Colors.grey;
          case 2:
            dot1 = Colors.grey;
            dot2 = Colors.grey;
            dot3 = Color.fromRGBO(29, 78, 216, 1);
            dot4 = Colors.grey;
            dot5 = Colors.grey;
          case 3:
            dot1 = Colors.grey;
            dot2 = Colors.grey;
            dot3 = Colors.grey;
            dot4 = Color.fromRGBO(29, 78, 216, 1);
            dot5 = Colors.grey;
          case 4:
            dot1 = Colors.grey;
            dot2 = Colors.grey;
            dot3 = Colors.grey;
            dot4 = Colors.grey;
            dot5 = Color.fromRGBO(29, 78, 216, 1);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color.fromARGB(50, 25, 155, 120),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Image.asset(
              "entities/images/notification.png",
              width: 50.5,
              height: 50.5,
            ),
            onPressed: () {},
          ),
          const BagButtonWidget(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            //Arama Butonu
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Search Anything...",
                  prefixIcon: Image.asset(
                    "entities/images/search-normal.png",
                    height: 10,
                    width: 10,
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide:
                          BorderSide(color: Color(0xFFD1D5DB), width: 1)),
                ),
              ),
            ),
            //Katagoriler
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(
                      color: Color(0xFF1F2937),
                      fontSize: 14,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                      height: 0.11,
                      letterSpacing: 0.07,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "View All ->",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 12,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                      height: 0.12,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            //Katagori Resimler (Kaydırma)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FutureBuilder(
                  future:
                      FirebaseFirestore.instance.collection('categories').get(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      final categoryList =
                          snapshot.data!.docs.map((e) => e.data()).toList();
                      return Row(
                        children: [
                          const SizedBox(
                            width: 6,
                          ),
                          for (final data in categoryList)
                            CategoryWidget(
                              title: data['name'],
                              imageUrl: data['imageUrl'],
                            ),
                          const SizedBox(
                            width: 16,
                          ),
                        ],
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            const SizedBox(
              height: 16,
            ),
            //Slider
            Container(
              width: 360,
              height: 154,
              child: PageView(
                controller: controller,
                children: <Widget>[
                  Center(
                    child: Image.asset("entities/images/Slider1.png"),
                  ),
                  Center(
                    child: Image.asset("entities/images/Slider2.jpg"),
                  ),
                  Center(
                    child: Image.asset("entities/images/Slider3.jpg"),
                  ),
                  Center(
                    child: Image.asset("entities/images/Slider4.jpg"),
                  ),
                  Center(
                    child: Image.asset("entities/images/Slider5.jpg"),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
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
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
            //Deal of the day + Sayaç + Özel indirimler
            Container(
              color: const Color.fromRGBO(246, 246, 246, 1),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0),
                      child: Row(
                        children: [
                          const Text(
                            "Deal of the day",
                            style: TextStyle(
                              color: Color(0xFF1F2937),
                              fontSize: 14,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                              height: 0.11,
                              letterSpacing: 0.07,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "View All ->",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 12,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w400,
                              height: 0.12,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 2),
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color.fromARGB(255, 239, 68, 68),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                "${_timeUntilTarget.inDays} DAY ${_timeUntilTarget.inHours % 24} HRS ${_timeUntilTarget.inMinutes % 60} MIN ${_timeUntilTarget.inSeconds % 60} SEC",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset(
                                            "entities/images/Running.png"),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Running Shoes"),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Color.fromARGB(
                                                255, 239, 68, 68),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              "Upto 40% OFF",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 1)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      children: [
                                        Image.asset(
                                            "entities/images/Sneakers.png"),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Sneakers"),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Color.fromARGB(
                                                255, 239, 68, 68),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              "40-60% OFF",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 1)),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Image.asset(
                                              "entities/images/Wrist.png"),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Wrist Watches"),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Color.fromARGB(
                                                  255, 239, 68, 68),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                "Upto 40% OFF",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 1)),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        children: [
                                          Image.asset(
                                              "entities/images/Speaker.png"),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Bluetooth Speakers"),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Color.fromARGB(
                                                  255, 239, 68, 68),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                "40-60% OFF",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 1)),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //Hot Selling Footwear
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Hot Selling Footwear",
                    style: TextStyle(
                      color: Color(0xFF1F2937),
                      fontSize: 14,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                      height: 0.11,
                      letterSpacing: 0.07,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "View All ->",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 12,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                      height: 0.12,
                    ),
                  )
                ],
              ),
            ),
            FutureBuilder(
                future: FirebaseFirestore.instance.collection('products').get(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    final products = snapshot.data!.docs
                        .map((e) => ProductModel.fromFirestore(e.data(), e.id));
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        for (final product in products)
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: HomepageProductWidget(product: product),
                          ),
                      ]),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }),
            SizedBox(
              height: 20,
            ),
            // Recommended for you
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Recommended for you",
                    style: TextStyle(
                      color: Color(0xFF1F2937),
                      fontSize: 14,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                      height: 0.11,
                      letterSpacing: 0.07,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "View All ->",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 12,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                      height: 0.12,
                    ),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Image.asset(
                    "entities/images/Allen2.png",
                    width: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "entities/images/Calvin3.png",
                    width: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Image.asset(
                    "entities/images/H&M2.png",
                    width: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "entities/images/Calvin4.png",
                    width: 150,
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            backgroundColor: Color.fromARGB(50, 25, 155, 120),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Category",
            backgroundColor: Color.fromARGB(50, 25, 155, 120),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: "Orders",
            backgroundColor: Color.fromARGB(50, 25, 155, 120),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin),
            label: "Profile",
            backgroundColor: Color.fromARGB(50, 25, 155, 120),
          ),
        ],
        selectedLabelStyle: TextStyle(color: Colors.black),
        unselectedLabelStyle: TextStyle(color: Colors.black),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

// Veri Tipleri
// Değişken Tanımlama
String selamlamaMetni = "Hello Flutter";

int sayi = 5;

String isim = "Emre";
String soyisim = "Taştekin";

int yas = 21;

double kilo = 71;

bool askerlikYaptiMi = false;

List<int> okullaGecenYillar = [2013, 2014, 2015, 2016, 2017, 2018, 2019];

Insan serbay = Insan("Emre", "Taştekin", 21, 71, false,
    [2013, 2014, 2015, 2016, 2017, 2018, 2019]);

Ogrenci tuncay = Ogrenci("Murat", "Parlak", 21, 80, false, okullaGecenYillar,
    "123456", "Yıldız Teknik Üniversitesi");

class Insan {
  String isim;
  String soyisim;
  int yas;
  double kilo;
  bool askerlikYaptiMi;
  List<int> okullaGecenYillar;

  Insan(this.isim, this.soyisim, this.yas, this.kilo, this.askerlikYaptiMi,
      this.okullaGecenYillar) {
    print("İnsan sınıfı oluşturuldu.");
  }
}

void islem(String Metin, int sayi) {
  for (int i = 0; i < sayi; i++) {
    print(Metin);
  }
}

class Ogrenci extends Insan {
  String okulNumara;
  String okulIsmi;

  Ogrenci(
      super.isim,
      super.soyisim,
      super.yas,
      super.kilo,
      super.askerlikYaptiMi,
      super.okullaGecenYillar,
      this.okulNumara,
      this.okulIsmi) {
    print("Öğrenci sınfı oluşturuldu.");
  }
}
