
class NewsModel {
  String? status;
  int? totalResults;
  List<Articles>? articles;

  NewsModel({
    this.status,
    this.totalResults,
    this.articles,
  });

  NewsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];

    if (json['articles'] != null) {
      articles = <Articles>[];

      json['articles'].forEach((v) {
        articles!.add(Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['status'] = status;
    data['totalResults'] = totalResults;

    if (articles != null) {
      data['articles'] =
          articles!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Articles {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;

  Articles({
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
  });

  Articles.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['author'] = author;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['urlToImage'] = urlToImage;

    return data;
  }
}
