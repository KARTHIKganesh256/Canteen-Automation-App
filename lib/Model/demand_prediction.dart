class PredictionPoint {
  final String date;
  final int quantity;

  PredictionPoint({this.date, this.quantity});

  factory PredictionPoint.fromJson(Map<String, dynamic> json) {
    return PredictionPoint(
      date: json['date']?.toString() ?? json['day']?.toString() ?? '',
      quantity: (json['quantity'] is num) ? (json['quantity'] as num).toInt() : int.tryParse(json['quantity']?.toString() ?? '0') ?? 0,
    );
  }
}

class DemandPrediction {
  final String itemId;
  final List<PredictionPoint> points;

  DemandPrediction({this.itemId, this.points});

  factory DemandPrediction.fromJson(Map<String, dynamic> json) {
    List<PredictionPoint> pts = [];
    if (json['prediction'] is List) {
      pts = (json['prediction'] as List).map((e) => PredictionPoint.fromJson(e)).toList();
    } else if (json['predictions'] is List) {
      pts = (json['predictions'] as List).map((e) => PredictionPoint.fromJson(e)).toList();
    }
    return DemandPrediction(
      itemId: json['item_id']?.toString() ?? json['id']?.toString() ?? '',
      points: pts,
    );
  }
}
