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
  String get tmtGameTmtHelpTmtATitle => "Instructions: TMT Part A";

  @override
  String get tmtGameTmtHelpTmtADescription =>
      "Numbers contained in circles will be shown. Please connect with your finger the circles with the numbers in ascending order, starting from the lowest number and continuing with the next in order. "
          "\n\n• Start at 1, then 2, then 3, and so on.( 1 → 2 → 3 → ...) "
          "\n\n• Respond accurately as fast as you can.";

  @override
  String get tmtGameTmtHelpTmtBTitle => "TMT B Help";

  @override
  String get tmtGameTmtHelpTmtBDescription =>
      "Numbers and letters contained in circles will be shown. Please connect with your finger the circles alternating between numbers and letters in ascending/alphabetical order. Start at number 1, then letter A. Then number 2, then letter B. Respond accurately as fast as you can.";

  @override
  String get tmtGameTmtHelpTmtSecondaryButtonText => "Start Formal Test";

  @override
  String get tmtGameCountdownMessage => 'Get ready! The test will start in...';

  @override
  String get tmtGameTmtHelpGeneralTitle => "Welcome to dTMT Test";

  @override
  String get tmtGameTmtHelpGeneralDescription =>
      "Welcome to the dTMT test. This test consists of two parts (Part A and Part B). Each part will begin with a brief training phase to familiarize you with the task, followed immediately by the corresponding timed test.\n\nImportant:\n\n• Each training phase (Practice A and Practice B) will be performed only once.\n\n• Once Practice A is completed, you will proceed directly to Test A, which cannot be repeated.\n\n• Similarly, when you complete Practice B, you will proceed directly to Test B, which also cannot be repeated.\n\n• This ensures the validity of the results and avoids the effect of learning by repetition in the tests.";

  @override
  String get tmtGameTmtHelpGeneralButtonText => "Start";

  @override
  String get tmtGameTmtHelpTmtAButtonText => "Start Practice Part A";

  @override
  String get tmtGameTmtHelpTmtBButtonText => "Start Practice Part B";

  //--------------------------------------------Home Header Text------------------------------------------------------
  @override
  String get homeHeaderSelectThemeTitle => "Select Theme";

  @override
  String get homeHeaderLightModeOption => "Light Mode";

  @override
  String get homeHeaderDarkModeOption => "Dark Mode";

  @override
  String get homeHeaderSystemThemeOption => "System Theme";

  @override
  String get languageNameEnglish => "EN";

  @override
  String get languageNameSpanish => "ES";

  @override
  String get languageNameChinese => "中文";

  //--------------------------------------------TMT Practice Text------------------------------------------------------
  @override
  String get tmtGamePracticeTmtAPageTitle => "TMT A Practice";

  @override
  String get tmtGamePracticeTmtBPageTitle => "TMT B Practice";

  @override
  String get tmtGamePracticeCompletedADialogTitle => "Practice Part A Completed!";

  @override
  String get tmtGamePracticeCompletedADialogContent =>
      "You have completed the Part A training. Now you will start Test A. Remember, this part is timed and cannot be repeated.";

  @override
  String get tmtGamePracticeCompletedADialogButtonText => "Start Test A";

  @override
  String get tmtGamePracticeCompletedBDialogTitle => "Practice Part B Completed!";

  @override
  String get tmtGamePracticeCompletedBDialogContent =>
      "You have completed the Part B training. Now you will start Test B. Remember, this part is timed and cannot be repeated.";

  @override
  String get tmtGamePracticeCompletedBDialogButtonText => "Start Test B";

  //--------------------------------------------TMT Select Hand Dialog Text------------------------------------------------------
  @override
  String get tmtSelectHandDialogFirstTimeTitle => "Select TMT Test Hand";

  @override
  String get tmtSelectHandDialogFirstTimeContent =>
      "Please select which hand you would like to use for this TMT test. Future tests may require alternating hands to ensure a comprehensive assessment.";

  @override
  String get tmtSelectHandDialogLeftHandButtonText => "Left\nHand";

  @override
  String get tmtSelectHandDialogRightHandButtonText => "Right\nHand";

  @override
  String get tmtSelectHandDialogRightHandOnlyTitle =>
      "TMT Test: Please Use Right Hand";

  @override
  String get tmtSelectHandDialogRightHandOnlyContent =>
      "You used your left hand in your previous TMT test. To ensure valid results, please use your right hand for this test.";

  @override
  String get tmtSelectHandDialogUseRightHandButton =>
      "Start Test with Right Hand";

  @override
  String get tmtSelectHandDialogLeftHandOnlyTitle =>
      "TMT Test: Please Use Left Hand";

  @override
  String get tmtSelectHandDialogLeftHandOnlyContent =>
      "You used your right hand in your previous TMT test. To ensure valid results, please use your left hand for this test.";

  @override
  String get tmtSelectHandDialogUseLeftHandButton =>
      "Start Test with Left Hand";

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
  String get registerUserSaveSuccess => "Profile successfully registered";

  @override
  String get registerUserSaveError => "Error saving profile. Please try again.";

  //--------------------------------------------Current User Data Screen Text------------------------------------------------------
  @override
  String get currentUserDataScreenTitle => "My Profile";

  @override
  String get currentUserDataScreenNoUserFound => "No user profile found";

  @override
  String get currentUserDataScreenCreateProfile => "Create Profile";

  @override
  String get currentUserDataScreenDeleteProfile => "Delete Profile";

  @override
  String get currentUserDataScreenBackButton => "Back";

  @override
  String get currentUserDataScreenConfirmDeleteTitle => "Confirm Delete";

  @override
  String get currentUserDataScreenConfirmDeleteContent =>
      "Are you sure you want to delete this profile? This action cannot be undone.";

  @override
  String get currentUserDataScreenConfirmDeleteButton => "Delete";

  @override
  String get currentUserDataScreenCancelButton => "Cancel";

  @override
  String get currentUserDataScreenDeleteSuccess =>
      "Profile deleted successfully";

  @override
  String get currentUserDataScreenDeleteError => "Error deleting profile";

  //--------------------------------------------User Result History Screen Text------------------------------------------------------
  @override
  String get userResultHistoryScreenTitle => "My Tests";

  @override
  String get userResultHistoryScreenNoData => "No results available";

  @override
  String get userResultHistoryScreenDateHeader => "Date";

  @override
  String get userResultHistoryScreenReferenceHeader => "Reference";

  @override
  String get userResultHistoryScreenTmtAHeader => "TMT-A";

  @override
  String get userResultHistoryScreenTmtBHeader => "TMT-B";

  @override
  String get userResultHistoryScreenSecondsUnit => "s";

  @override
  String get userResultHistoryScreenHandUsedHeader => "Hand Used";

  @override
  String get userResultHistoryScreenRightHand => "Right";

  @override
  String get userResultHistoryScreenLeftHand => "Left";

  //--------------------------------------------Reference Code Input Text------------------------------------------------------

  @override
  String get referenceCodeInputLabel => "Reference";

  @override
  String get referenceCodeInputBothFieldsRequired =>
      "Please complete both fields";

  @override
  String get referenceCodeInputEnterReferenceCode =>
      "Please enter a reference code";

  @override
  String get referenceCodeInputCodeAlreadyUsed =>
      "The reference code has already been used";

  @override
  String get referenceCodeInputValidReferenceCode => "Valid reference code";

  @override
  String get referenceCodeInputIncorrectReference =>
      "The reference is not correct. Please verify it or contact your neurologist";

  @override
  String get referenceCodeInputValidationError => "Error validating the code: ";

  //--------------------------------------------Select User Profile Dialog Text------------------------------------------------------
  @override
  String get selectUserProfileDialogTitle => "Select profile";

  @override
  String get selectUserProfileDialogNoProfiles => "No profiles available";

  @override
  String get selectUserProfileDialogCancelButton => "Cancel";

  @override
  String get selectUserProfileDialogDeleteConfirmTitle => "Delete profile";

  @override
  String get selectUserProfileDialogDeleteConfirmContent =>
      "Are you sure you want to delete the profile \"{user}\"?";

  @override
  String get selectUserProfileDialogDeleteButton => "Delete";

  @override
  String get selectUserProfileDialogCancelDeleteButton => "Cancel";

  @override
  String get selectUserProfileDialogProfileDeletedSuccess => "Profile deleted:";

  @override
  String get selectUserProfileDialogProfileDeletedError =>
      "Error deleting profile";

  @override
  String get selectUserProfileDialogProfileSelectedSuccess =>
      "Profile selected";

  @override
  String get selectUserProfileDialogProfileSelectedError =>
      "Error setting profile";

  @override
  String get selectUserProfileDialogSearchAnchorSearchBarHint =>
      "Search profiles";

  @override
  String get selectUserProfileDialogSearchAnchorSearchBarNotFound =>
      'No profiles match your search';

  //--------------------------------------------Select User Dropdown Text------------------------------------------------------
  @override
  String get selectUserDropdownCreateUser => "Create profile";

  @override
  String get selectUserDropdownGreeting => "Hello, ";

  //--------------------------------------------TMT Test Button Card Text------------------------------------------------------
  @override
  String get tmtTestButtonCardStartTest => "Start\nTMT Test";

  @override
  String get tmtTestButtonCardNumberOfCircles => "Number of Circles";

  @override
  String get tmtTestButtonCardDialogTitle => "Number of Circles";

  @override
  String get tmtTestButtonCardChooseBetween => "Choose between:";

  @override
  String get tmtTestButtonCardCompleteTest => "25 circles: Complete test.";

  @override
  String get tmtTestButtonCardSimplifiedVersion =>
      "15 circles: Simplified version for small screens.";

  @override
  String get tmtTestButtonCardConsultNeurologist =>
      "For more details, consult with your neurologist.";

  @override
  String get tmtTestButtonCardUnderstood => "Understood";

  @override
  String get tmtTestButtonCardCancel => "Cancel";

//--------------------------------------------Home Card Button Text------------------------------------------------------
  @override
  String get homeCardButtonVisualizeMyData => "View my profile";

  @override
  String get homeCardButtonViewMyHistory => "View my tests";

  @override
  String get homeCardButtonCreateNewProfile => "Create New Profile";
}

final en = EnglishMessages();
