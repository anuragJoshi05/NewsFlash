import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'model.dart';

class Category extends StatefulWidget {
  String Query;
  Category({required this.Query});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<NewsQueryModel> newsModelList = <NewsQueryModel>[];
  bool isLoading = true;
  Future<void> getNewsByQuery(String query) async {
    String url = "";
    if (query == "Top News" || query == "India") {
      url = "https://newsapi.org/v2/top-headlines?country=in&apiKey=6d520596ed064f07aa0b4dc4e3d3f4b1";
    } else {
      url = "https://newsapi.org/v2/everything?q=$query&from=2024-05-03&sortBy=publishedAt&apiKey=6d520596ed064f07aa0b4dc4e3d3f4b1";
    }

    try {
      Response response = await get(Uri.parse(url));
      Map data = jsonDecode(response.body);

      for (var element in data["articles"]) {
        try {
          NewsQueryModel newsQueryModel = NewsQueryModel.fromMap(element);
          newsModelList.add(newsQueryModel);
        } catch (e) {
          print("Error parsing article: $e");
        }
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching news: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getNewsByQuery(widget.Query);
  }

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
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(25, 25, 30, 15),
                    child : Text(
                      widget.Query.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 33,
                      ),
                    ),
                  ),
                ],
              ),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: newsModelList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin:
                              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                                    errorBuilder: (context, error, stackTrace) {
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
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 15, 10, 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          newsModelList[index].newsHead.length >
                                                  50
                                              ? "${newsModelList[index].newsHead.substring(0, 50)}..."
                                              : newsModelList[index].newsHead,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          newsModelList[index].newsDes.length > 50
                                              ? "${newsModelList[index].newsDes.substring(0, 50)}..."
                                              : newsModelList[index].newsDes,
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
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
