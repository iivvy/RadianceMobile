class SavedAppSettings{
  String language;
  String theme;
  SavedAppSettings(
  { required this.language,
    required this.theme

});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["language"] = language;
    data["theme"] = theme;
    return data;
  }

  @override
  String toString() {
    return 'SavedAppSettings(language: $language, theme: $theme)';
  }
}