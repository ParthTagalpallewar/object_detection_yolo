class ShoppingCartItem {
  String _imagePath;
  String _label;
  double _cost;
  double _confidence;

  // Constructor
  ShoppingCartItem({
    required String imagePath,
    required String label,
    required double cost,
    required double confidence,
  })  : _imagePath = imagePath,
        _label = label,
        _cost = cost,
        _confidence = confidence;

  // Getter for imagePath
  String get imagePath => _imagePath;

  // Setter for imagePath
  set imagePath(String value) {
    _imagePath = value;
  }

  // Getter for label
  String get label => _label;

  // Setter for label
  set label(String value) {
    _label = value;
  }

  // Getter for cost
  double get cost => _cost;

  // Setter for cost
  set cost(double value) {
    if (value >= 0) {
      _cost = value;
    } else {
      throw ArgumentError("Cost cannot be negative");
    }
  }

  // Getter for confidence
  double get confidence => _confidence;

  // Setter for confidence
  set confidence(double value) {
    if (value >= 0 && value <= 1) {
      _confidence = value;
    } else {
      throw ArgumentError("Confidence must be between 0 and 1");
    }
  }

  // ToString method for better readability
  @override
  String toString() {
    return 'ShoppingCartItem(imagePath: $_imagePath, label: $_label, cost: $_cost, confidence: $_confidence)';
  }

  factory ShoppingCartItem.fromJson(Map<String, dynamic> json, String imagePath) {
    return ShoppingCartItem(
      imagePath: imagePath,
      label: json['label'],
      cost: json['cost'].toDouble(),
      confidence: json['confidence'].toDouble(),
    );
  }
}
