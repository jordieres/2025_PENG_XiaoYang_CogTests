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
  String get tmtGameTmtHelpTmtADescription =>
      "Se mostrarán números contenidos en círculos. Por favor, conecta con tu dedo los círculos con los números en orden ascendente, empezando desde el número más bajo y continuando con el siguiente en orden. Empieza en 1, luego 2, luego 3, y continúa. Responde con precisión lo más deprisa que puedas.";

  @override
  String get tmtGameTmtHelpTmtBTitle => "TMT B Ayuda";

  @override
  String get tmtGameTmtHelpTmtBDescription =>
      "Se mostrarán números y letras contenidos en círculos. Por favor, conecta con tu dedo los círculos alternando entre números y letras en orden ascendente / alfabético. Empieza en el número 1, luego la letra A. Luego el número 2, y luego la letra B. Responde con precisión lo más deprisa que puedas.";

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

  //--------------------------------------------TMT Select Hand Dialog Text------------------------------------------------------
  @override
  String get tmtSelectHandDialogTitle => "Selecciona tu mano dominante";

  @override
  String get tmtSelectHandDialogContent => "Usa la mano con la que te sientas más cómodo para realizar la prueba. Esto optimiza tu experiencia TMT test.";

  @override
  String get tmtSelectHandDialogRightHandButtonText => "Mano derecha";

  @override
  String get tmtSelectHandDialogLeftHandButtonText => "Mano izquierda";


  //--------------------------------------------Select Mode Practice Or Test Screen Text------------------------------------------------------
  @override
  String get selectModePracticeOrTestTitle => "Seleccionar Modo";

  @override
  String get selectModePracticeOrTestQuestionText =>
      "¿Qué modalidad prefieres?";

  @override
  String get selectModePracticeOrTestPracticeButtonText => "Práctica";

  @override
  String get selectModePracticeOrTestTestButtonText => "Test Formal";

  @override
  String get selectModePracticeOrTestPracticeModeTitle => "Modo Práctica";

  @override
  String get selectModePracticeOrTestPracticeModeContent =>
      "En este modo, podrás practicar el test sin que se registren tus resultados oficiales. Es ideal para que te familiarices con el procedimiento y puedas corregir errores sin presión.";

  @override
  String get selectModePracticeOrTestTestModeTitle => "Test Formal";

  @override
  String get selectModePracticeOrTestTestModeContent =>
      "Selecciona este modo para iniciar el test evaluativo. Aquí se registrarán tus tiempos y errores para calcular tu score. Asegúrate de estar listo, ya que este test se considera definitivo.";

  @override
  String get selectModePracticeOrTestButtonUnderstood => "Entendido";

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

  @override
  String get tmtResultScreenSecondsUnit => "s";

  @override
  String get tmtResultScreenErrorMessage => "Error al enviar resultados";

  //--------------------------------------------Register User Screen Text------------------------------------------------------
  @override
  String get registerUserTitle => "Crear nuevo perfil";

  @override
  String get registerUserNicknameLabel => "Apodo";

  @override
  String get registerUserNicknameHint => "Introduce un apodo";

  @override
  String get registerUserNicknameError => "Por favor introduce un apodo";

  @override
  String get registerUserNicknameExistsError => "Este apodo ya está en uso";

  @override
  String get registerUserSexLabel => "Sexo";

  @override
  String get registerUserSexMale => "Masculino";

  @override
  String get registerUserSexFemale => "Femenino";

  @override
  String get registerUserSexError => "Por favor selecciona un sexo";

  @override
  String get registerUserBirthDateLabel => "Fecha de nacimiento";

  @override
  String get registerUserBirthDateHint => "Seleccionar fecha";

  @override
  String get registerUserBirthDateError => "Por favor selecciona una fecha";

  @override
  String get registerUserBirthDatePickerTitle =>
      "Seleccionar fecha de nacimiento";

  @override
  String get registerUserBirthDatePickerCancel => "Cancelar";

  @override
  String get registerUserBirthDatePickerConfirm => "Aceptar";

  @override
  String get registerUserEducationLabel => "Nivel de estudios";

  @override
  String get registerUserEducationHint => "Seleccionar nivel de estudios";

  @override
  String get registerUserEducationError =>
      "Por favor selecciona un nivel de estudios";

  @override
  String get registerUserEducationPrimary => "Estudios Primarios";

  @override
  String get registerUserEducationSecondary => "Estudios Secundarios";

  @override
  String get registerUserEducationGraduate => "Grado Universitario";

  @override
  String get registerUserEducationMaster => "Máster Universitario";

  @override
  String get registerUserEducationDoctorate => "Doctorado";

  @override
  String get registerUserSaveButton => "Guardar";

  @override
  String get registerUserCancelButton => "Cancelar";

  @override
  String get registerUserFormError =>
      "Por favor, rellena todos los campos marcados.";

  @override
  String get registerUserSaveSuccess => "Usuario registrado correctamente";

  @override
  String get registerUserSaveError =>
      "Error al guardar el usuario. Inténtalo de nuevo.";

  //--------------------------------------------Current User Data Screen Text------------------------------------------------------
  @override
  String get currentUserDataScreenTitle => "Perfil de Usuario";

  @override
  String get currentUserDataScreenNoUserFound => "No se encontró perfil de usuario";

  @override
  String get currentUserDataScreenCreateProfile => "Crear Perfil";

  @override
  String get currentUserDataScreenDeleteProfile => "Eliminar Perfil";

  @override
  String get currentUserDataScreenBackButton => "Volver";

  @override
  String get currentUserDataScreenConfirmDeleteTitle => "Confirmar Eliminación";

  @override
  String get currentUserDataScreenConfirmDeleteContent =>
      "¿Estás seguro de que quieres eliminar este perfil de usuario? Esta acción no se puede deshacer.";

  @override
  String get currentUserDataScreenConfirmDeleteButton => "Eliminar";

  @override
  String get currentUserDataScreenCancelButton => "Cancelar";

  @override
  String get currentUserDataScreenDeleteSuccess => "Perfil de usuario eliminado correctamente";

  @override
  String get currentUserDataScreenDeleteError => "Error al eliminar el perfil de usuario";
}

final es = SpanishMessages();