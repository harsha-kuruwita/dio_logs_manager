import 'dart:collection';

import 'package:dio_logs_manager/src/data/logs_pool.dart';
import 'package:dio_logs_manager/src/data/models/net_options.dart';
import 'package:dio_logs_manager/src/ui/components/net_options_list_tile.dart';
import 'package:flutter/material.dart';

import 'components/overlay_draggable_button.dart';

///Main Page where [NetOptions] are listed
class LogsPage extends StatefulWidget {
  const LogsPage({Key? key}) : super(key: key);

  @override
  State<LogsPage> createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  @override
  Widget build(BuildContext context) {
    // Removed theme dependency to use explicit styles.
    final keys = LogPoolManager.getInstance()!.keys;
    return Scaffold(
      // Set the background color of the page to white.
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Request Logs"),
        // Set AppBar background to white.
        backgroundColor: Colors.white,
        // Set AppBar title text style to have black color.
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
        ),
        // Set AppBar icons to be black.
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 1.0,
        actions: [
          InkWell(
            onTap: () {
              if (debugBtnIsShow()) {
                dismissDebugBtn();
              } else {
                showDebugBtn(context);
              }
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Align(
                child: Text(
                  debugBtnIsShow() ? 'close overlay' : 'open overlay',
                  // Set action text style to be black.
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              LogPoolManager.getInstance()!.clear();
              setState(() {});
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Align(
                child: Text(
                  'clear',
                  // Set action text style to be black.
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder<LinkedHashMap<String, NetOptions>>(
        valueListenable: LogPoolManager.getInstance()!.logMapNotifier,
        builder: (context, map, child) {
          return map.isEmpty
              ? const Center(
                  // Set the placeholder text color to black.
                  child: Text(
                    'No request log',
                    style: TextStyle(color: Colors.black),
                  ),
                )
              : ListView.builder(
                  reverse: false,
                  itemCount: map.length,
                  itemBuilder: (BuildContext context, int index) {
                    // Note: The `NetOptionsListTile` widget will use default styles.
                    // If it internally relies on `Theme.of(context)`, it may need
                    // to be updated separately to ensure a consistent look.
                    return NetOptionsListTile(
                      key: ValueKey(keys[index]),
                      item: map[keys[index]]!,
                    );
                  },
                );
        },
      ),
    );
  }
}
