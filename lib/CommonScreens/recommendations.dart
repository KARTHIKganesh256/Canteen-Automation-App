import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:canteen_app/Services/api_service.dart';
import 'package:canteen_app/Model/recommendation.dart';
import 'package:canteen_app/CommonScreens/description.dart';

class RecommendationsPage extends StatefulWidget {
  @override
  _RecommendationsPageState createState() => _RecommendationsPageState();
}

class _RecommendationsPageState extends State<RecommendationsPage> {
  final ApiService _api = ApiService();
  Future<List<Recommendation>> _future;

  @override
  void initState() {
    super.initState();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    _future = _api.getRecommendations(userId: uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommendations'),
      ),
      body: FutureBuilder<List<Recommendation>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final list = snapshot.data ?? [];
          if (list.isEmpty) {
            return Center(child: Text('No recommendations found'));
          }
          return ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final rec = list[index];
              return Card(
                child: ListTile(
                  leading: rec.image != null && rec.image.isNotEmpty
                      ? Image.network(rec.image, width: 48, height: 48, fit: BoxFit.cover)
                      : Container(width: 48, height: 48, color: Colors.grey[200]),
                  title: Text(rec.name ?? 'Unknown'),
                  subtitle: Text('Score: ${rec.score ?? 0}'),
                  onTap: () {
                    // Navigate to description if available
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Description(
                                  image: rec.image,
                                  name: rec.name,
                                  description: '',
                                  amount: '',
                                  category: '',
                                  review: 0,
                                  type: '',
                                  inv: '',
                                  docid: rec.id,
                                  rate1: 0,
                                  rate2: 0,
                                  rate3: 0,
                                  rate4: 0,
                                  rate5: 0,
                                  ratingcount: 0,
                                  reviewcount: 0,
                                )));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
