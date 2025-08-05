class ProgressModel {
  final String set;
  final String rep;
  final String weights;
  final String burnCalories;
  final String distanceRun;

  ProgressModel({
    required this.set,
    required this.rep,
    required this.weights,
    required this.burnCalories,
    required this.distanceRun,
  });

  Map<String, dynamic> toMap() => {
        'set': set,
        'rep': rep,
        'weights': weights,
        'burnCalories': burnCalories,
        'distanceRun': distanceRun,
      };

  factory ProgressModel.fromMap(Map<String, dynamic> data) {
    return ProgressModel(
      set: data["set"],
      rep: data["rep"],
      weights: data["weights"],
      burnCalories: data["burnCalories"],
      distanceRun: data["distanceRun"],
    );
  }
}

class ProgressAdapter {
  // Converts a Map to a ProgressModel
  static ProgressModel fromMap(Map<String, dynamic> data) {
    return ProgressModel(
      set: data["set"],
      rep: data["rep"],
      weights: data["weights"],
      burnCalories: data["burnCalories"],
      distanceRun: data["distanceRun"],
    );
  }

  // Converts a ProgressModel to a Map
  static Map<String, dynamic> toMap(ProgressModel progress) {
    return {
      'set': progress.set,
      'rep': progress.rep,
      'weights': progress.weights,
      'burnCalories': progress.burnCalories,
      'distanceRun': progress.distanceRun,
    };
  }
}
