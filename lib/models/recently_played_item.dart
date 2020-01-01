class RecentlyPlayedItem {
  String id;
  String type;
  DateTime lastPlayed;
  String thumbnailUrl;
  String title;
  String audioUrl;

  RecentlyPlayedItem(
      {this.id,
      this.type,
      this.lastPlayed,
      this.thumbnailUrl,
      this.title,
      this.audioUrl});
}
