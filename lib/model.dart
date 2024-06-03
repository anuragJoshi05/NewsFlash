class NewsQueryModel {
  late String newsHead;
  late String newsDes;
  late String newsImg;
  late String newsUrl;

  NewsQueryModel({
    this.newsHead = "NEWS HEADLINE",
    this.newsDes = "DESCRIPTION",
    this.newsImg = "IMAGE",
    this.newsUrl = "LINK",
  });

  factory NewsQueryModel.fromMap(Map news) {
    return NewsQueryModel(
      newsHead: news["title"] ?? "NEWS HEADLINE",
      newsDes: news["description"] ?? "DESCRIPTION",
      newsImg: news["urlToImage"] ?? "https://via.placeholder.com/400",
      newsUrl: news["url"] ?? "LINK",
    );
  }
}
