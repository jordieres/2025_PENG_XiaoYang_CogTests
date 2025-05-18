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
  String get tmtGameTmtHelpTmtATitle => "Instrucciones: TMT Parte A";

  @override
  String get tmtGameTmtHelpTmtADescription =>
      "Se mostrarán números contenidos en círculos. Por favor, conecta con tu dedo los círculos con los números en orden ascendente, empezando desde el número más bajo y continuando con el siguiente en orden. "
      "\n\n• Empieza en 1, luego 2, luego 3, y continúa. ( 1 → 2 → 3 → ...) "
      "\n\n• Responde con precisión lo más deprisa que puedas.";

  @override
  String get tmtGameTmtHelpTmtBTitle => "TMT B Ayuda";

  @override
  String get tmtGameTmtHelpTmtBDescription =>
      "Se mostrarán números y letras contenidos en círculos. Por favor, conecta con tu dedo los círculos alternando entre números y letras en orden ascendente / alfabético. Empieza en el número 1, luego la letra A. Luego el número 2, y luego la letra B. Responde con precisión lo más deprisa que puedas.";

  @override
  String get tmtGameTmtHelpTmtSecondaryButtonText => "Inicar Test Formal";

  @override
  String get tmtGameCountdownMessage => "¡Prepárate! La prueba comenzará en...";

  @override
  String get tmtGameTmtHelpGeneralTitle => "Bienvenido al Test dTMT";

  @override
  String get tmtGameTmtHelpGeneralDescription =>
      "Bienvenido al test dTMT. Esta prueba consta de dos partes (Parte A y Parte B). Cada parte comenzará con una breve fase de entrenamiento para familiarizarte con la tarea, seguida inmediatamente por el test cronometrado correspondiente.\n\nImportante:\n\n• Cada fase de entrenamiento (Práctica A y Práctica B) se realizará una sola vez.\n\n• Una vez finalizada la Práctica A, pasarás directamente al Test A, el cual no se podrá repetir.\n\n• De igual manera, al finalizar la Práctica B, pasarás directamente al Test B, que tampoco se podrá repetir.\n\n• Esto asegura la validez de los resultados y evita el efecto del aprendizaje por repetición en los tests.";

  @override
  String get tmtGameTmtHelpGeneralButtonText => "Comenzar";

  @override
  String get tmtGameTmtHelpTmtAButtonText => "Comenzar Práctica Parte A";

  @override
  String get tmtGameTmtHelpTmtBButtonText => "Comenzar Práctica Parte B";

  //--------------------------------------------Home Header Text------------------------------------------------------
  @override
  String get homeHeaderSelectThemeTitle => "Seleccionar Tema";

  @override
  String get homeHeaderLightModeOption => "Modo Claro";

  @override
  String get homeHeaderDarkModeOption => "Modo Oscuro";

  @override
  String get homeHeaderSystemThemeOption => "Tema del Sistema";

  @override
  String get languageNameEnglish => "EN";

  @override
  String get languageNameSpanish => "ES";

  @override
  String get languageNameChinese => "中文";

  //--------------------------------------------TMT Practice Text------------------------------------------------------
  @override
  String get tmtGamePracticeTmtAPageTitle => "Práctica TMT A";

  @override
  String get tmtGamePracticeTmtBPageTitle => "Práctica TMT B";

  @override
  String get tmtGamePracticeCompletedADialogTitle =>
      "¡Práctica Parte A Terminada!";

  @override
  String get tmtGamePracticeCompletedADialogContent =>
      "Has completado el entrenamiento de la Parte A. Ahora comenzarás el Test A. Recuerda, esta parte es cronometrada y no se puede repetir.";

  @override
  String get tmtGamePracticeCompletedADialogButtonText => "Iniciar Test A";

  @override
  String get tmtGamePracticeCompletedBDialogTitle =>
      "¡Práctica Parte B Terminada!";

  @override
  String get tmtGamePracticeCompletedBDialogContent =>
      "Has completado el entrenamiento de la Parte B. Ahora comenzarás el Test B. Recuerda, esta parte es cronometrada y no se puede repetir.";

  @override
  String get tmtGamePracticeCompletedBDialogButtonText => "Iniciar Test B";

  //--------------------------------------------TMT Select Hand Dialog Text------------------------------------------------------
  @override
  String get tmtSelectHandDialogFirstTimeTitle =>
      "Seleccione la mano para el Test TMT";

  @override
  String get tmtSelectHandDialogFirstTimeContent =>
      "Por favor, seleccione qué mano desea utilizar para este test TMT. Pruebas futuras podrían requerir alternar ambas manos para garantizar una evaluación completa.";

  @override
  String get tmtSelectHandDialogLeftHandButtonText => "Mano\nizquierda";

  @override
  String get tmtSelectHandDialogRightHandButtonText => "Mano\nderecha";

  @override
  String get tmtSelectHandDialogRightHandOnlyTitle =>
      "Test TMT: Por favor use la mano derecha";

  @override
  String get tmtSelectHandDialogRightHandOnlyContent =>
      "Usted utilizó su mano izquierda en el test TMT anterior. Para garantizar resultados válidos, por favor use su mano derecha para este test.";

  @override
  String get tmtSelectHandDialogUseRightHandButton =>
      "Iniciar test con mano derecha";

  @override
  String get tmtSelectHandDialogLeftHandOnlyTitle =>
      "Test TMT: Por favor use la mano izquierda";

  @override
  String get tmtSelectHandDialogLeftHandOnlyContent =>
      "Usted utilizó su mano derecha en el test TMT anterior. Para garantizar resultados válidos, por favor use su mano izquierda para este test.";

  @override
  String get tmtSelectHandDialogUseLeftHandButton =>
      "Iniciar test con mano izquierda";

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
  String get registerUserSaveSuccess => "Perfil registrado correctamente";

  @override
  String get registerUserSaveError =>
      "Error al guardar el perfil. Inténtalo de nuevo.";

  //--------------------------------------------Current User Data Screen Text------------------------------------------------------
  @override
  String get currentUserDataScreenTitle => "Mi Perfil";

  @override
  String get currentUserDataScreenNoUserFound =>
      "No se encontró perfil de usuario";

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
      "¿Estás seguro de que quieres eliminar este perfil? Esta acción no se puede deshacer.";

  @override
  String get currentUserDataScreenConfirmDeleteButton => "Eliminar";

  @override
  String get currentUserDataScreenCancelButton => "Cancelar";

  @override
  String get currentUserDataScreenDeleteSuccess =>
      "Perfil eliminado correctamente";

  @override
  String get currentUserDataScreenDeleteError => "Error al eliminar el perfil";

  //--------------------------------------------User Result History Screen Text------------------------------------------------------
  @override
  String get userResultHistoryScreenTitle => "Mis Tests";

  @override
  String get userResultHistoryScreenNoData => "No hay resultados disponibles";

  @override
  String get userResultHistoryScreenDateHeader => "Fecha";

  @override
  String get userResultHistoryScreenReferenceHeader => "Referencia";

  @override
  String get userResultHistoryScreenTmtAHeader => "TMT-A";

  @override
  String get userResultHistoryScreenTmtBHeader => "TMT-B";

  @override
  String get userResultHistoryScreenSecondsUnit => "s";

  @override
  String get userResultHistoryScreenHandUsedHeader => "Mano Usada";

  @override
  String get userResultHistoryScreenRightHand => "Derecha";

  @override
  String get userResultHistoryScreenLeftHand => "Izquierda";

//--------------------------------------------Reference Code Input Text------------------------------------------------------
  @override
  String get referenceCodeInputLabel => "Referencia";

  @override
  String get referenceCodeInputBothFieldsRequired =>
      "Por favor, complete ambos campos";

  @override
  String get referenceCodeInputEnterReferenceCode =>
      "Por favor, introduce un código de referencia";

  @override
  String get referenceCodeInputCodeAlreadyUsed =>
      "El código de referencia ya ha sido utilizado";

  @override
  String get referenceCodeInputValidReferenceCode =>
      "Código de referencia válido";

  @override
  String get referenceCodeInputIncorrectReference =>
      "La referencia no es correcta. Por favor verifíquela o contacte al neurólogo.";

  @override
  String get referenceCodeInputValidationError =>
      "Error al validar el código: ";

  //--------------------------------------------Select User Profile Dialog Text------------------------------------------------------
  @override
  String get selectUserProfileDialogTitle => "Seleccionar perfil";

  @override
  String get selectUserProfileDialogNoProfiles => "No hay perfiles disponibles";

  @override
  String get selectUserProfileDialogCancelButton => "Cancelar";

  @override
  String get selectUserProfileDialogDeleteConfirmTitle => "Eliminar perfil";

  @override
  String get selectUserProfileDialogDeleteConfirmContent =>
      "¿Está seguro que desea eliminar el perfil \"{user}\"?";

  @override
  String get selectUserProfileDialogDeleteButton => "Eliminar";

  @override
  String get selectUserProfileDialogCancelDeleteButton => "Cancelar";

  @override
  String get selectUserProfileDialogProfileDeletedSuccess =>
      "Perfil eliminado:";

  @override
  String get selectUserProfileDialogProfileDeletedError =>
      "Error al eliminar perfil";

  @override
  String get selectUserProfileDialogProfileSelectedSuccess =>
      "Perfil seleccionado";

  @override
  String get selectUserProfileDialogProfileSelectedError =>
      "Error al establecer perfil";

  @override
  String get selectUserProfileDialogSearchAnchorSearchBarHint =>
      "Buscar perfiles";

  @override
  String get selectUserProfileDialogSearchAnchorSearchBarNotFound =>
      'Ningún perfil coincide con tu búsqueda';

  //--------------------------------------------Select User Dropdown Text------------------------------------------------------
  @override
  String get selectUserDropdownCreateUser => "Crear perfil";

  @override
  String get selectUserDropdownGreeting => "Hola, ";

  //--------------------------------------------TMT Test Button Card Text------------------------------------------------------
  @override
  String get tmtTestButtonCardStartTest => "Empezar\nTest TMT";

  @override
  String get tmtTestButtonCardNumberOfCircles => "Número de Círculos";

  @override
  String get tmtTestButtonCardDialogTitle => "Número de Círculos";

  @override
  String get tmtTestButtonCardChooseBetween => "Elige entre:";

  @override
  String get tmtTestButtonCardCompleteTest => "25 círculos: Test completo.";

  @override
  String get tmtTestButtonCardSimplifiedVersion =>
      "15 círculos: Versión simplificada para pantallas pequeñas.";

  @override
  String get tmtTestButtonCardConsultNeurologist =>
      "Para más detalles, consulta con tu neurólogo.";

  @override
  String get tmtTestButtonCardUnderstood => "Entendido";

  @override
  String get tmtTestButtonCardCancel => "Cancelar";

  //--------------------------------------------Home Card Button Text------------------------------------------------------
  @override
  String get homeCardButtonVisualizeMyData => "Ver mi Perfil";

  @override
  String get homeCardButtonViewMyHistory => "Ver mis Tests";

  @override
  String get homeCardButtonCreateNewProfile => "Crear nuevo perfil";
}

final es = SpanishMessages();
