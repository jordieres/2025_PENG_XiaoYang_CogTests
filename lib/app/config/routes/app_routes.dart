part of 'app_pages.dart';

/// used to switch pages
class Routes {
  static const home = _Paths.home;
  static const tmt_test = _Paths.tmt_test;
  static const tmt_results = _Paths.tmt_results;
}

/// contains a list of route names.
// made separately to make it easier to manage route naming
class _Paths {
  static const home = '/home';
  static const tmt_test = '/tmt_test';
  static const tmt_results = '/tmt_results';
}