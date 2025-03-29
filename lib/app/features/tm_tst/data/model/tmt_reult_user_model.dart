
import 'package:msdtmt/app/features/tm_tst/domain/entities/tmt_user_data.dart';

class TmtUserModel extends TmtUserData {
  TmtUserModel({
    required String mano,
    required String nivelEduc,
    required DateTime fNacimiento,
    required String sexo,
  }) : super(
    mano: mano,
    nivelEduc: nivelEduc,
    fNacimiento: fNacimiento,
    sexo: sexo,
  );

  factory TmtUserModel.fromEntity(TmtUserData entity) {
    return TmtUserModel(
      mano: entity.mano,
      nivelEduc: entity.nivelEduc,
      fNacimiento: entity.fNacimiento,
      sexo: entity.sexo,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'F_nacimiento': _formatDate(fNacimiento),
      'Sexo': sexo,
      'Nivel_Educ': nivelEduc,
      'Mano': mano,
    };
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}