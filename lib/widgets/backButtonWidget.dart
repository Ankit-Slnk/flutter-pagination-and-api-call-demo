import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  Function onPressed;
  BackButtonWidget({
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        kIsWeb
            ? Icons.arrow_back
            : Platform.isAndroid
                ? Icons.arrow_back
                : Icons.arrow_back_ios,
      ),
    );
  }
}
