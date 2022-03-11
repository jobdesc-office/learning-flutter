import 'package:flutter/material.dart';

class MenuData {
  final int id;

  final String label;

  final String route;

  final bool active;

  final IconData icon;

  final List<MenuData> children;

  const MenuData({
    required this.id,
    required this.label,
    required this.route,
    this.icon = Icons.circle_outlined,
    this.active = false,
    this.children = const [],
  });

  factory MenuData.empty() {
    return MenuData(id: 0, label: '', route: '');
  }
}
