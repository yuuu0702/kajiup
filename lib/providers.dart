import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'models.dart';

final userProvider = StateProvider<User?>((ref) => FirebaseAuth.instance.currentUser);

final houseworksProvider = StreamProvider<List<Housework>>((ref) {
  final database = FirebaseDatabase.instance;
  final houseworkRef = database.ref('houseworks');

  return houseworkRef.onValue.map((event) {
    final houseworks = <Housework>[];

    for (final snapshot in event.snapshot.children) {
      final housework = Housework.fromJson(snapshot.data()!);
      houseworks.add(housework);
    }

    return houseworks;
  });
});

final selectedHouseworkProvider = StateProvider<Housework?>((ref) => null);

final scheduleProvider = StateProvider<String>((ref) => '');

final levelProvider = StateProvider<int>((ref) => 0);

final isCompletedListProvider = Provider<List<bool>>((ref) {
  final houseworks = ref.watch(houseworksProvider);
  return houseworks.map((housework) => housework.isCompleted).toList();
});

final houseworksListByTypeProvider = Provider<List<Housework>>((ref) {
  final houseworks = ref.watch(houseworksProvider);
  final type = ref.watch(selectedHouseworkProvider)?.type;

  if (type == null) {
    return [];
  }

  return houseworks.where((housework) => housework.type == type).toList();
});

final houseworksListByScheduleProvider = Provider<List<Housework>>((ref) {
  final houseworks = ref.watch(houseworksProvider);
  final schedule = ref.watch(scheduleProvider);

  if (schedule == '') {
    return [];
  }

  return houseworks.where((housework) => housework.schedule == schedule).toList();
});

final houseworksListByLevelProvider = Provider<List<Housework>>((ref) {
  final houseworks = ref.watch(houseworksProvider);
  final level = ref.watch(levelProvider);

  if (level == 0) {
    return [];
  }

  return houseworks.where((housework) => housework.level == level).toList();
});

final houseworksListByIsCompletedProvider = Provider<List<Housework>>((ref) {
  final houseworks = ref.watch(houseworksProvider);
  final isCompleted = ref.watch(isCompletedProvider);

  if (isCompleted == false) {
    return [];
  }

  return houseworks.where((housework) => housework.isCompleted == isCompleted).toList();
});

final houseworksListByDateProvider = Provider<List<Housework>>((ref) {
  final houseworks = ref.watch(houseworksProvider);
  final date = ref.watch(scheduleProvider);

  if (date == '') {
    return [];
  }

  final dateTime = DateFormat('yyyy/MM/dd').parse(date);

  return houseworks.where((housework) => housework.schedule.toDate() == dateTime).toList();
});

final houseworksListByTimeProvider = Provider<List<Housework>>((ref) {
  final houseworks = ref.watch(houseworksProvider);
  final time = ref.watch(scheduleProvider);

  if (time == '') {
    return [];
  }

  final dateTime = DateFormat('HH:mm').parse(time);

  return houseworks.where((housework) => housework.schedule.toTime() == dateTime).toList();
});