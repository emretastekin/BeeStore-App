import '../folder.dart';
import 'package:flutter/material.dart';

void main() {
  print("successful first process");
  process(text, number);

  //String _name = "Emre";

  Widget myApp = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Image.asset(
              'entities/images/notification.png',
              width: 24,
              height: 24,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset(
              'entities/images/bag.png',
              width: 24,
              height: 24,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Search Anything...",
                prefixIcon: Image.asset(
                  'entities/images/search.png',
                  width: 24,
                  height: 24,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      color: Color(0xFFD1D5DB),
                      width: 1,
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0.11,
                    letterSpacing: 0.07,
                  ),
                ),
                Spacer(),
                Text(
                  'View All ->',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0.12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 35),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              Column(children: [
                Image.asset(
                  'entities/images/fashion.png',
                  width: 29,
                  height: 24,
                ),
                Text("Fashion"),
                SizedBox(width: 95.05),
              ]),
              Column(children: [
                Image.asset(
                  'entities/images/electronic.png',
                  width: 29,
                  height: 24,
                ),
                Text("Electronics"),
                SizedBox(width: 95.05),
              ]),
              Column(children: [
                Image.asset('entities/images/appliances.png',
                    width: 23, height: 24),
                Text("Appliances"),
                SizedBox(width: 95.05),
              ]),
              Column(children: [
                Image.asset(
                  'entities/images/beauty.png',
                  width: 11.56,
                  height: 24,
                ),
                Text("Beauty"),
                SizedBox(width: 95.05),
              ]),
              Column(children: [
                Image.asset(
                  'entities/images/furniture.png',
                  width: 30,
                  height: 24,
                ),
                Text("Furniture"),
                SizedBox(width: 95.05),
              ]),
              Column(children: [
                Image.asset(
                  'entities/images/fashion.png',
                  width: 29,
                  height: 24,
                ),
                Text("Fashion"),
                SizedBox(width: 95.05),
              ]),
              Column(children: [
                Image.asset(
                  'entities/images/electronic.png',
                  width: 29,
                  height: 24,
                ),
                Text("Electronics"),
                SizedBox(width: 95.05),
              ]),
              Column(children: [
                Image.asset('entities/images/appliances.png',
                    width: 23, height: 24),
                Text("Appliances"),
                SizedBox(width: 95.05),
              ]),
              Column(children: [
                Image.asset(
                  'entities/images/beauty.png',
                  width: 11.56,
                  height: 24,
                ),
                Text("Beauty"),
                SizedBox(width: 95.05),
              ]),
              Column(children: [
                Image.asset(
                  'entities/images/furniture.png',
                  width: 30,
                  height: 24,
                ),
                Text("Furniture"),
                SizedBox(width: 95.05),
              ]),
            ]),
          ),
        ],
      ),
      drawer: const Drawer(),
    ),
  );

  runApp(myApp);
}

String text = "Hello Flutter";
int number = 5;

String name = "Emre";
String surname = "Taştekin";

int age = 22;

double weight = 71.5;
bool isMilitaryService = false;

List<int> schoolsYear = [2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020];

People emre = People("Emre", "Taştekin", 22, 71.5, false,
    [2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020]);

class People {
  String name;
  String surname;
  int age;
  double weight;
  bool isMilitaryService;
  List<int> schoolsYear;

  People(this.name, this.surname, this.age, this.weight, this.isMilitaryService,
      this.schoolsYear) {
    print("created people class");
  }
}
