import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'providers.dart';
import 'housework_details_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainScreen extends HookConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final houseworks = ref.watch(houseworksProvider);
    final selectedHousework = ref.watch(selectedHouseworkProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('kajiapp'),
      ),
      body: ListView.builder(
        itemCount: houseworks.toString().length,
        itemBuilder: (BuildContext context, int index) {
          final housework = houseworks[index];
          return ListTile(
            title: Text(housework.type),
            subtitle: Text(housework.schedule),
            onTap: () {
              // 家事を完了状態にする
              housework.isCompleted = true;

              // 家事のデータを保存する
              //saveHousework(housework.type, housework.schedule);

              // 家事詳細画面に遷移する
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => HouseworkDetailsScreen(
                    housework: housework,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
