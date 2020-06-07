import 'package:DollarCheck/domain/media/media.dart';

class Logo implements Media {
  @override
  final String url;

  Logo(this.url);

  @override
  MediaType get type => MediaType.image;
}
