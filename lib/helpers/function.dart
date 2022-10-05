import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:date_time_format/date_time_format.dart';

import '../presenters/navigation_presenter.dart';

String notNull(dynamic value, {String? nullValue}) {
  String newValue = value.toString();
  if (value == null && nullValue != null)
    newValue = nullValue;
  else if (value == null && nullValue == null)
    newValue = '';
  else if (value != null && value == '' && nullValue != null)
    newValue = nullValue;

  return newValue;
}

double parseDouble(dynamic value, {int decimal = 2}) {
  return value == null ? 0.0 : double.parse(value.toString());
}

int parseInt(dynamic value) {
  return value == null ? 0 : int.parse(value.toString());
}

String parseString(dynamic value) {
  return value == null ? '' : value.toString();
}

DateTime? parseDate(dynamic value) {
  return value == null ? null : DateTime.parse(value.toString());
}

String dateFormat(DateTime? dateTime,
    {String format = 'd F Y H:i:s', String nullValue = '-'}) {
  return dateTime != null
      ? DateTimeFormat.format(dateTime, format: format)
      : nullValue;
}

bool parseBool(dynamic value) {
  return value == null
      ? false
      : (value is String)
          ? value == 'true'
              ? true
              : false
          : value;
}

IconData parseIcon(dynamic value) {
  Map<String, IconData> icons = {
    'Icons.dashboard': Icons.dashboard,
    'Icons.storage_outlined': Icons.storage_outlined,
    'Icons.handshake': Icons.handshake,
    'Icons.groups': Icons.groups,
    'FontAwesomeIcons.userPlus': FontAwesomeIcons.userPlus,
    'Icons.contacts': Icons.contacts,
    'Icons.analytics': Icons.analytics,
    'FontAwesomeIcons.calendarDays': FontAwesomeIcons.calendarDays,
    'FontAwesomeIcons.addressBook': FontAwesomeIcons.addressBook,
    'Icons.settings_outlined': Icons.settings_outlined,
    'Icons.domain': Icons.domain,
    'Icons.file_open': Icons.file_open,
    'Icons.key': Icons.key,
    // ignore: deprecated_member_use
    'FontAwesomeIcons.earthAmerica': FontAwesomeIcons.earthAmerica,
    'FontAwesomeIcons.city': FontAwesomeIcons.city,
    'FontAwesomeIcons.globe': FontAwesomeIcons.globe,
    'FontAwesomeIcons.locationDot': FontAwesomeIcons.locationDot,
    'Icons.square': Icons.square,
    'Icons.category': Icons.category,
  };
  return value == null ? Icons.circle_outlined : icons[value]!;
}

void toNameRoute(String name, {bool pushReplace = false}) {
  final navigation = Get.find<NavigationPresenter>();

  navigation.to(name, pushReplace: pushReplace);
}

formatBytes(int size, int precision) {
  String result;
  if (size <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(size) / log(1024)).floor();
  result =
      ((size / pow(1024, i)).toStringAsFixed(precision)) + ' ' + suffixes[i];
  return result;
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}
