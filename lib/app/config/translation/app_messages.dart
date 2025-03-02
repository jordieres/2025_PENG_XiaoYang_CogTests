part of 'app_translations.dart';

/// Add `.tr` to get translation value
///
/// Example :
/// ```dart
/// Keyword.language.tr
/// ```
///
/// Result :
/// * en : `Language`
/// * id : `Bahasa`
class Messages {
  static String accountType = 'account_type';
  static String alreadyHaveAccount = 'already_have_account';
}

abstract class BaseMessages {
  String get accountType;
  String get alreadyHaveAccount;

  Map<String, String> get messages => {
        Messages.accountType: accountType,
        Messages.alreadyHaveAccount: alreadyHaveAccount,
      };
}
