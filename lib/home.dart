import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:newsflash/model.dart';
import 'package:http/http.dart';
import 'package:newsflash/newsView.dart';
import 'category.dart';
import 'dart:math';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<NewsQueryModel> newsModelList = <NewsQueryModel>[];
  List<NewsQueryModel> newsModelListCarousel = <NewsQueryModel>[];
  List<String> navBarItem = [
    "Breaking News",
    "India",
    "Sports",
    "Health",
    "LifeStyle",
    "Business"
  ];
  List<String> newsCategories = [
    "World News",
    "Politics",
    "Technology",
    "Science",
    "Entertainment",
    "Travel",
    "Food",
    "Opinion",
    "Weather",
    "Education",
    "Environment",
    "Culture",
    "Automotive",
    "Fashion",
    "Real Estate",
    "Crime",
    "Celebrity News",
    "Gaming",
    "Music",
    "Art",
    "History",
    "Religion"
  ];
  Random random = Random();
  late int randomIndex;
  late String randomCategory;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    randomIndex = random.nextInt(newsCategories.length);
    randomCategory = newsCategories[randomIndex];
    getNewsOfIndia();
    getNewsByQuery("Breaking News");
  }

  Future<void> getNewsByQuery(String query) async {
    Map element;
    int i = 0;

    try {
      String url =
          "https://newsapi.org/v2/everything?q=$query&from=2024-05-03&sortBy=publishedAt&apiKey=6d520596ed064f07aa0b4dc4e3d3f4b1";
      Response response = await get(Uri.parse(url));
      Map data = jsonDecode(response.body);

      for (element in data["articles"]) {
        try {
          NewsQueryModel newsQueryModel = NewsQueryModel.fromMap(element);
          newsModelList.add(newsQueryModel);
        } catch (e) {
          print("Error parsing article: $e");
        }

        i++;
        if (i == 12) break;
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching news: $e");
    }
  }

  Future<void> getNewsOfIndia() async {
    Map element;
    int i = 0;

    try {
      String url =
          "https://newsapi.org/v2/top-headlines?country=in&apiKey=6d520596ed064f07aa0b4dc4e3d3f4b1";
      Response response = await get(Uri.parse(url));
      Map data = jsonDecode(response.body);

      for (element in data["articles"]) {
        try {
          NewsQueryModel newsQueryModel = NewsQueryModel.fromMap(element);
          newsModelListCarousel.add(newsQueryModel);
        } catch (e) {
          print("Error parsing article: $e");
        }

        i++;
        if (i == 12) break;
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching news: $e");
    }
  }

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
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if ((searchController.text).replaceAll(" ", "") == "") {
                          print("Blank search");
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Category(Query: searchController.text)));
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                        child: const Icon(
                          Icons.search,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        style: const TextStyle(color: Colors.greenAccent),
                        onSubmitted: (value) {
                          if (value == "") {
                            print("Blank Search not possible");
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Category(Query: value)));
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search ${newsCategories[randomIndex]}",
                          hintStyle: const TextStyle(color: Colors.yellow),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.yellow,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Category(Query: navBarItem[index]),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
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
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: isLoading
                  ? Container(
                      height: 200,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : CarouselSlider(
                      options: CarouselOptions(
                        height: 200,
                        enableInfiniteScroll: false,
                        autoPlay: true,
                        enlargeCenterPage: true,
                      ),
                      items: newsModelListCarousel.map((instance) {
                        return Builder(builder: (BuildContext context) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NewsView(instance.newsUrl)));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      instance.newsImg,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'images/newsFlashLogo.png',
                                          fit: BoxFit.cover,
                                          height: 200,
                                          width: double.infinity,
                                        );
                                      },
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
                                        ),
                                      ),
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 15, 10, 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            instance.newsHead.length > 40
                                                ? "${instance.newsHead.substring(0, 45)}..."
                                                : "${instance.newsHead}...",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
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
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Background color
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // Add padding
                        decoration: BoxDecoration(
                          color:
                              Colors.black, // Background color of the container
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 2, // Spread radius
                              blurRadius: 5, // Blur radius
                              offset: const Offset(0, 2), // Shadow offset
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center align the contents
                          children: [
                            Icon(
                              Icons.article_rounded,
                              color: Colors.yellow, // Icon color
                              size: 32,
                            ),
                            SizedBox(
                                width: 10), // Spacing between icon and text
                            Text(
                              "LATEST NEWS",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                color: Colors.yellow, // Text color
                              ),
                            ),
                          ],
                        ),
                      )),
                  isLoading
                      ? SizedBox(
                          height: 220,
                          child: Center(child: CircularProgressIndicator()))
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: newsModelList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewsView(
                                              newsModelList[index].newsUrl)));
                                },

                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(
                                          newsModelList[index].newsImg,
                                          fit: BoxFit.cover,
                                          height: 200,
                                          width: double.infinity,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'images/newsFlashLogo.png',
                                              fit: BoxFit.cover,
                                              height: 200,
                                              width: double.infinity,
                                            );
                                          },
                                        ),
                                      ),
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
                                            ),
                                          ),
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 15, 10, 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                newsModelList[index]
                                                            .newsHead
                                                            .length >
                                                        50
                                                    ? "${newsModelList[index].newsHead.substring(0, 50)}..."
                                                    : newsModelList[index]
                                                        .newsHead,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                newsModelList[index]
                                                            .newsDes
                                                            .length >
                                                        50
                                                    ? "${newsModelList[index].newsDes.substring(0, 50)}..."
                                                    : newsModelList[index]
                                                        .newsDes,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Category(
                                        Query: newsCategories[randomIndex])));
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blueGrey, // Text color
                            elevation: 3, // Elevation
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // Border radius
                            ),
                          ),
                          child: const Text("SHOW MORE"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
