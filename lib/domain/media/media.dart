abstract class Media {
  final String url;
  final MediaType type;

  Media(this.url, this.type);
}

enum MediaType { image, gif }
