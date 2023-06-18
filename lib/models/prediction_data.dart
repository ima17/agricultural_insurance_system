class PredictionData {
  final String premiumRate;
  final String givenSumAssured;
  final String monthlyPremium;

  PredictionData({
    required this.premiumRate,
    required this.givenSumAssured,
    required this.monthlyPremium,
  });

  factory PredictionData.fromJson(Map<String, dynamic> json) {
    return PredictionData(
      premiumRate: json['premium_rate'],
      givenSumAssured: json['given_sum_assured'],
      monthlyPremium: json['monthly_premium'],
    );
  }
}
