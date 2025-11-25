import 'package:flutter/material.dart';

abstract class ProfileEvent {}

class ToggleTheme extends ProfileEvent {}


class ChangeLanguage extends ProfileEvent {
  final Locale locale;
  ChangeLanguage(this.locale);
}
