import 'package:intl/intl.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/result/tmt_user_data.dart';

import '../../../../constans/send_tmt_result_date_formatter.dart';
import '../../../user/data/model/user_profile_model.dart';

class TmtUserModel extends TmtUserData {
  TmtUserModel({
    required String nivelEduc,
    required DateTime fNacimiento,
    required String sexo,
  }) : super(
          nivelEduc: nivelEduc,
          fNacimiento: fNacimiento,
          sexo: sexo,
        );

  factory TmtUserModel.fromEntity(TmtUserData entity) {
    return TmtUserModel(
      nivelEduc: entity.nivelEduc,
      fNacimiento: entity.fNacimiento,
      sexo: entity.sexo,
    );
  }

  factory TmtUserModel.fromUserProfile(UserProfileModel entity) {
    return TmtUserModel(
      nivelEduc: entity.educationLevel.value,
      fNacimiento: entity.birthDate,
      sexo: entity.sex.value,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'F_nacimiento': _formatDate(fNacimiento),
      'Sexo': sexo,
      'Nivel_Educ': nivelEduc
    };
  }

  String _formatDate(DateTime date) {
    return DateFormat(SendTMTResultDateFormatter.TMT_TEST_RESULT_SEND_BIRTHDAY_FORMATTER, SendTMTResultDateFormatter.DATE_LOCALE).format(date);
  }
}
