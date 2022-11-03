library share_to;

import 'package:flutter/widgets.dart';

import 'share_to_stub.dart' if (dart.library.io) 'io.dart' if (dart.library.html) 'html.dart';

abstract class ShareTo {
  factory ShareTo() => getShareTo();

  Future<void> share(BuildContext context, String text);
}
