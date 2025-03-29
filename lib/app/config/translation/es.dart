part of 'app_translations.dart';

// spanish
class SpanishMessages extends BaseMessages {
  @override
  String get tmtGameCircleBegin => "Inicio";

  @override
  String get tmtGameCircleEnd => "Fin";

  @override
  String get tmtGamePartACompletedTitle => "TMT Parte A Completada";

  @override
  String get tmtGamePartACompletedBody =>
      "Has completado con éxito la Parte A de TMT. ¿Listo para comenzar la Parte B de TMT?";

  @override
  String get tmtGamePartBCompletedConfirmationButton =>
      "Sí, Comenzar TMT Parte B";

  @override
  String get tmtGameTmtScreenAppBarTime => "Tiempo: ";

  @override
  String get tmtGameTmtHelpTmtATitle => "TMT A Ayuda";

  @override
  String get tmtGameTmtHelpTmtBTitle => "TMT B Ayuda";

  @override
  String get tmtGameTmtHelpTmtPrimaryButtonText => "Quiero practicar";

  @override
  String get tmtGameTmtHelpTmtSecondaryButtonText => "Inicar Test Formal";

  //--------------------------------------------TMT Practice Text------------------------------------------------------
  @override
  String get tmtGamePracticeTmtAThenBDialogTitle =>
      "¿Repetir esta práctica TMT A o avanzar al siguiente desafío?";

  @override
  String get tmtGamePracticeTmtAThenBDialogCancelButtonText => "Avanzar";

  @override
  String get tmtGamePracticeTmtAThenBDialogPrimaryButtonText => "Repetir";

  @override
  String get tmtGamePracticeOnlyTmtAOrTmtBDialogTitle =>
      "¿Estás listo para empezar el test TMT?";

  @override
  String get tmtGamePracticeOnlyTmtAOrTmtBDialogCancelButtonText =>
      "Sí, empezar";

  @override
  String get tmtGamePracticeOnlyTmtAOrTmtBDialogPrimaryButtonText =>
      "No, repetir";

  @override
  String get tmtGamePracticeTmtAPageTitle => "Práctica TMT A";

  @override
  String get tmtGamePracticeTmtBPageTitle => "Práctica TMT B";

  //--------------------------------------------TMT Result Screen Text------------------------------------------------------
  @override
  String get tmtResultScreenTitle => "Resultado:";

  @override
  String get tmtResultScreenSessionText => "Número de Sesiones";

  @override
  String get tmtResultScreenTmtATitle => "TMT A";

  @override
  String get tmtResultScreenTmtBTitle => "TMT B";

  @override
  String get tmtResultScreenDurationLabel => "Duración";

  @override
  String get tmtResultScreenErrorsLabel => "Errores";

  @override
  String get tmtResultScreenThanksMessage =>
      "Le agradecemos la confianza, el tiempo y el esfuerzo en realizar este test dTMT";

  @override
  String get tmtResultScreenFinishButton => "Terminar";

  @override
  String get tmtResultScreenLoadingResults => "Cargando resultados...";
}

final es = SpanishMessages();
