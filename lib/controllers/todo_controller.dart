import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../models/pengajuan_seminar.dart';

enum FilterOption {
  all,
  active,
  completed,
}

class TodoController extends ChangeNotifier {
  // =====================
  // TODO LIST
  // =====================

  final List<Todo> _todos = [];
  FilterOption _filter = FilterOption.all;

  List<Todo> get todos {
    switch (_filter) {
      case FilterOption.active:
        return _todos.where((e) => !e.completed).toList();

      case FilterOption.completed:
        return _todos.where((e) => e.completed).toList();

      case FilterOption.all:
        return _todos;
    }
  }

  int get totalCount => _todos.length;

  int get activeCount =>
      _todos.where((e) => !e.completed).length;

  int get completedCount =>
      _todos.where((e) => e.completed).length;

  void addTodo(
    String title, {
    bool isImportant = false,
  }) {
    _todos.add(
      Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        isImportant: isImportant,
      ),
    );

    notifyListeners();
  }

  void toggleTodo(String id) {
    final index =
        _todos.indexWhere((todo) => todo.id == id);

    if (index != -1) {
      _todos[index] = _todos[index].copyWith(
        completed: !_todos[index].completed,
      );

      notifyListeners();
    }
  }

  void removeTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);

    notifyListeners();
  }

  void setFilter(FilterOption filter) {
    _filter = filter;

    notifyListeners();
  }

  // =====================
  // PENGAJUAN SEMINAR
  // =====================

  final List<PengajuanSeminar> _pengajuanList = [];

  List<PengajuanSeminar> get pengajuanList =>
      List.unmodifiable(_pengajuanList);

  int get totalPengajuan =>
      _pengajuanList.length;

  int get totalLengkap =>
      _pengajuanList
          .where((e) => e.berkasLengkap)
          .length;

  int get totalBelumLengkap =>
      _pengajuanList
          .where((e) => !e.berkasLengkap)
          .length;

  void addPengajuan(
    PengajuanSeminar pengajuan,
  ) {
    _pengajuanList.add(pengajuan);

    notifyListeners();
  }

  void updatePengajuan(
    int index,
    PengajuanSeminar pengajuan,
  ) {
    if (index >= 0 &&
        index < _pengajuanList.length) {
      _pengajuanList[index] = pengajuan;

      notifyListeners();
    }
  }

  void removePengajuan(int index) {
    if (index >= 0 &&
        index < _pengajuanList.length) {
      _pengajuanList.removeAt(index);

      notifyListeners();
    }
  }

  PengajuanSeminar? getPengajuan(int index) {
    if (index >= 0 &&
        index < _pengajuanList.length) {
      return _pengajuanList[index];
    }

    return null;
  }

  void clearAllPengajuan() {
    _pengajuanList.clear();

    notifyListeners();
  }
}