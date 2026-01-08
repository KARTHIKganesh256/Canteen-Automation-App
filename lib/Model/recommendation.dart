class Recommendation {
  final String id;
  final String name;
  final double score;
  final String image;

  Recommendation({this.id, this.name, this.score, this.image});

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      id: json['id']?.toString() ?? json['item_id']?.toString(),
      name: json['name'] ?? json['Itemname'] ?? json['title'] ?? '',
      score: (json['score'] != null)
          ? (json['score'] is num ? (json['score'] as num).toDouble() : double.tryParse(json['score'].toString()) ?? 0.0)
          : 0.0,
      image: json['image'] ?? json['image_url'] ?? '',
    );
  }
}
