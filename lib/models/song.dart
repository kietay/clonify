class Song {
  String songId;
  String songTitle;
  String releasedTimestamp;
  String audioUrl;
  String performedBy;
  String writtenBy;
  String producedBy;
  String source;
  int numberOfPlays;
  String artistId;
  String thumbnailUrl;

  Song(
      {this.songId,
      this.songTitle,
      this.releasedTimestamp,
      this.audioUrl,
      this.performedBy,
      this.writtenBy,
      this.producedBy,
      this.source,
      this.numberOfPlays,
      this.artistId,
      this.thumbnailUrl});
}
