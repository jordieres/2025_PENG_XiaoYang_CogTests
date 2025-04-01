part of 'app_translations.dart';

/// English
class EnglishMessages extends BaseMessages {
  @override
  String get tmtGameCircleBegin => "Begin";

  @override
  String get tmtGameCircleEnd => "End";

  @override
  String get tmtGamePartACompletedTitle => "TMT Part A Completed";

  @override
  String get tmtGamePartACompletedBody =>
      "You have successfully completed TMT Part A. Ready to start TMT Part B?";

  @override
  String get tmtGamePartBCompletedConfirmationButton => "Yes, Start TMT Part B";

  @override
  String get tmtGameTmtScreenAppBarTime => "Time: ";

  @override
  String get tmtGameTmtHelpTmtATitle => "TMT A Help";

  @override
  String get tmtGameTmtHelpTmtBTitle => "TMT B Help";

  @override
  String get tmtGameTmtHelpTmtPrimaryButtonText => "I want to practice";

  @override
  String get tmtGameTmtHelpTmtSecondaryButtonText => "Start Formal Test";

  //--------------------------------------------TMT Practice Text------------------------------------------------------
  @override
  String get tmtGamePracticeTmtAThenBDialogTitle =>
      "Repeat this TMT A practice or move on to the next challenge?";

  @override
  String get tmtGamePracticeTmtAThenBDialogCancelButtonText => "Move on";

  @override
  String get tmtGamePracticeTmtAThenBDialogPrimaryButtonText => "Repeat";

  @override
  String get tmtGamePracticeOnlyTmtAOrTmtBDialogTitle =>
      "Are you ready to start the TMT test?";

  @override
  String get tmtGamePracticeOnlyTmtAOrTmtBDialogCancelButtonText =>
      "Yes, start";

  @override
  String get tmtGamePracticeOnlyTmtAOrTmtBDialogPrimaryButtonText =>
      "No, repeat";

  @override
  String get tmtGamePracticeTmtAPageTitle => "TMT A Practice";

  @override
  String get tmtGamePracticeTmtBPageTitle => "TMT B Practice";

  //--------------------------------------------TMT Result Screen Text------------------------------------------------------
  @override
  String get tmtResultScreenTitle => "Result:";

  @override
  String get tmtResultScreenSessionText => "Number of Sessions";

  @override
  String get tmtResultScreenTmtATitle => "TMT A";

  @override
  String get tmtResultScreenTmtBTitle => "TMT B";

  @override
  String get tmtResultScreenDurationLabel => "Duration";

  @override
  String get tmtResultScreenErrorsLabel => "Errors";

  @override
  String get tmtResultScreenThanksMessage =>
      "Thank you for your trust, time and effort in completing this dTMT test";

  @override
  String get tmtResultScreenFinishButton => "Finish";

  @override
  String get tmtResultScreenLoadingResults => "Loading Results...";

  @override
  String get tmtResultScreenSecondsUnit => "s";
}

final en = EnglishMessages();