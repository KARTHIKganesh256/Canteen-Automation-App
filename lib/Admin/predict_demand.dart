import 'package:flutter/material.dart';
import 'package:canteen_app/Services/api_service.dart';
import 'package:canteen_app/Model/demand_prediction.dart';

class PredictDemandPage extends StatefulWidget {
  @override
  _PredictDemandPageState createState() => _PredictDemandPageState();
}

class _PredictDemandPageState extends State<PredictDemandPage> {
  final ApiService _api = ApiService();
  final TextEditingController _itemController = TextEditingController();
  Future<DemandPrediction> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Predict Demand')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _itemController,
              decoration: InputDecoration(labelText: 'Item ID or name'),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              child: Text('Predict'),
              onPressed: () {
                setState(() {
                  _future = _api.predictDemand(itemId: _itemController.text.trim());
                });
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: _future == null
                  ? Center(child: Text('Enter an item ID and press Predict'))
                  : FutureBuilder<DemandPrediction>(
                      future: _future,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
                        if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
                        final data = snapshot.data;
                        if (data == null || data.points.isEmpty) return Center(child: Text('No predictions'));
                        return ListView.separated(
                          itemCount: data.points.length,
                          separatorBuilder: (_, __) => Divider(height: 1),
                          itemBuilder: (context, index) {
                            final p = data.points[index];
                            return ListTile(
                              title: Text(p.date ?? ''),
                              trailing: Text('${p.quantity}'),
                            );
                          },
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
