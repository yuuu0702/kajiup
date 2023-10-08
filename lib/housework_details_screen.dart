import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'providers.dart';
import 'models.dart';

class HouseworkDetailsScreen extends HookWidget {
  final Housework housework;

  const HouseworkDetailsScreen({super.key,
    required this.housework,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${housework.type}の詳細'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '${housework.type}のスケジュール：${housework.schedule}',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '${housework.type}のレベル：${housework.level}',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '${housework.type}の完了状態：${housework.isCompleted ? '完了' : '未完了'}',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
