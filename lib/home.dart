import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> navBarItem = [
    "Breaking News",
    "India",
    "Sports",
    "Health",
    "LifeStyle",
    "Business"
  ];
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "NewsFlash",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.yellow),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.black, // Updated background color to black
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                        child: const Icon(
                          Icons.search,
                          color: Colors.yellow, // Updated icon color to yellow
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        style: const TextStyle(color: Colors.greenAccent),
                        onSubmitted: (value) {},
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "BreakingNews",
                          hintStyle: const TextStyle(
                              color: Colors
                                  .yellow), // Updated hint text color to yellow
                          suffixIcon: IconButton(
                            onPressed: () {
                              // Add your action here
                            },
                            icon: const Icon(
                              Icons.favorite,
                              color:
                                  Colors.yellow, // Updated icon color to yellow
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Container(
                margin: EdgeInsets.all(20),
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: navBarItem.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          print("$navBarItem");
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              navBarItem[index],
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: CarouselSlider(
                options: (CarouselOptions(
                  height: 200,
                  enableInfiniteScroll: false,
                  autoPlay: true,
                  enlargeCenterPage: true,
                )),
                items: itemList.map((itemList) {
                  return Builder(builder: (BuildContext context) {
                    return Container(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "images/breakingNews.jpeg",
                                fit: BoxFit.fill,
                                height: double.infinity,
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black.withOpacity(0),
                                          Colors.black,
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      )),
                                  padding: EdgeInsets.fromLTRB(10, 15, 10, 8),
                                  child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'NEWS HEADLINE',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        "News of the day",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.grey),
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),
                    );
                  });
                }).toList(),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.fromLTRB(15, 25, 0, 0),
                          child: const Text(
                            "LATEST NEWS",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 28),
                          )),
                    ],
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.asset(
                                          "images/breakingNews.jpeg")),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.black.withOpacity(0),
                                                Colors.black,
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            )),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 15, 10, 8),
                                        child: const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'NEWS HEADLINE',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "News of the day",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        )),
                                  )
                                ],
                              ),
                            ));
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: ElevatedButton(
                              onPressed: () {},
                              child: const Text("SHOW MORE"))),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  final List itemList = [
    Text("Who"),
    Text("are"),
    Text("you"),
    Text("Narendra Modi")
  ];
}
