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
  String get tmtGameTmtHelpTmtADescription =>
      "Numbers contained in circles will be shown. Please connect with your finger the circles with the numbers in ascending order, starting from the lowest number and continuing with the next in order. Start at 1, then 2, then 3, and so on. Respond accurately as fast as you can.";

  @override
  String get tmtGameTmtHelpTmtBTitle => "TMT B Help";

  @override
  String get tmtGameTmtHelpTmtBDescription =>
      "Numbers and letters contained in circles will be shown. Please connect with your finger the circles alternating between numbers and letters in ascending/alphabetical order. Start at number 1, then letter A. Then number 2, then letter B. Respond accurately as fast as you can.";

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

  //--------------------------------------------TMT Select Hand Dialog Text------------------------------------------------------
  @override
  String get tmtSelectHandDialogTitle => "Select your dominant hand";

  @override
  String get tmtSelectHandDialogContent =>
      "Use the hand you feel most comfortable with to take the test. This optimizes your TMT Test experience.";

  @override
  String get tmtSelectHandDialogRightHandButtonText => "Right hand";

  @override
  String get tmtSelectHandDialogLeftHandButtonText => "Left hand";

  //--------------------------------------------Select Mode Practice Or Test Screen Text------------------------------------------------------
  @override
  String get selectModePracticeOrTestTitle => "Select Mode";

  @override
  String get selectModePracticeOrTestQuestionText =>
      "Which mode do you prefer?";

  @override
  String get selectModePracticeOrTestPracticeButtonText => "Practice";

  @override
  String get selectModePracticeOrTestTestButtonText => "Formal Test";

  @override
  String get selectModePracticeOrTestPracticeModeTitle => "Practice Mode";

  @override
  String get selectModePracticeOrTestPracticeModeContent =>
      "In this mode, you can practice the test without registering your official results. It's ideal for familiarizing yourself with the procedure and correcting errors without pressure.";

  @override
  String get selectModePracticeOrTestTestModeTitle => "Formal Test";

  @override
  String get selectModePracticeOrTestTestModeContent =>
      "Select this mode to start the evaluation test. Your times and errors will be recorded to calculate your score. Make sure you are ready, as this test is considered definitive.";

  @override
  String get selectModePracticeOrTestButtonUnderstood => "Understood";

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

  @override
  String get tmtResultScreenErrorMessage => "Error Sending Results";

  //--------------------------------------------Register User Screen Text------------------------------------------------------
  @override
  String get registerUserTitle => "Create new profile";

  @override
  String get registerUserNicknameLabel => "Nickname";

  @override
  String get registerUserNicknameHint => "Enter a nickname";

  @override
  String get registerUserNicknameError => "Please enter a nickname";

  @override
  String get registerUserNicknameExistsError =>
      "This nickname is already in use";

  @override
  String get registerUserSexLabel => "Sex";

  @override
  String get registerUserSexMale => "Male";

  @override
  String get registerUserSexFemale => "Female";

  @override
  String get registerUserSexError => "Please select a sex";

  @override
  String get registerUserBirthDateLabel => "Date of birth";

  @override
  String get registerUserBirthDateHint => "Select date";

  @override
  String get registerUserBirthDateError => "Please select a date";

  @override
  String get registerUserBirthDatePickerTitle => "Select date of birth";

  @override
  String get registerUserBirthDatePickerCancel => "Cancel";

  @override
  String get registerUserBirthDatePickerConfirm => "Confirm";

  @override
  String get registerUserEducationLabel => "Education level";

  @override
  String get registerUserEducationHint => "Select education level";

  @override
  String get registerUserEducationError => "Please select an education level";

  @override
  String get registerUserEducationPrimary => "Primary Education";

  @override
  String get registerUserEducationSecondary => "Secondary Education";

  @override
  String get registerUserEducationGraduate => "University Degree";

  @override
  String get registerUserEducationMaster => "Master's Degree";

  @override
  String get registerUserEducationDoctorate => "Doctorate";

  @override
  String get registerUserSaveButton => "Save";

  @override
  String get registerUserCancelButton => "Cancel";

  @override
  String get registerUserFormError => "Please fill in all marked fields.";

  @override
  String get registerUserSaveSuccess => "User successfully registered";

  @override
  String get registerUserSaveError => "Error saving user. Please try again.";
}

final en = EnglishMessages();
