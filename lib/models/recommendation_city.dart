class RecommendationCity{
  String name;
  String image;
  String description;
  double rating;
  double score;

  RecommendationCity.fromJson(Map<String, dynamic> jsonObject)  {
    print(jsonObject);
    this.name = jsonObject['city'];
    this.image=jsonObject['image'];
    this.description=jsonObject['description'];

    if(jsonObject['rating']!=null)
      this.rating=jsonObject['rating'].toDouble();
    else rating=-1;
    this.score=jsonObject['score'];

  }

}

