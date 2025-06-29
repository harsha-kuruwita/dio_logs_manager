import 'package:flutter/material.dart';

import '../data/models/net_options.dart';

///LogRequestWidget Page where [ErrOptions] info is shown
class LogErrorWidget extends StatefulWidget {
  final NetOptions netOptions;

  const LogErrorWidget(this.netOptions, {Key? key}) : super(key: key);

  @override
  LogErrorWidgetState createState() => LogErrorWidgetState();
}

class LogErrorWidgetState extends State<LogErrorWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: double.infinity,
        child: Center(
          child: Text(
            widget.netOptions.errOptions?.errorMsg ?? 'no error',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
