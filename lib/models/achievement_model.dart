class AchievementModel {
  final String type;
  final String text;
  final String presentationText;

  AchievementModel(this.type, this.text, this.presentationText);

  static fromJson(Map<String, dynamic> json) => AchievementModel(
      json["type"] as String,
      json["text"] as String,
      json["presentationText"] == null
          ? json["text"] as String
          : json["presentationText"] as String);
}
