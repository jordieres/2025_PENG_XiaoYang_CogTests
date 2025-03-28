import 'package:flutter/material.dart';
import '../../../../config/themes/AppColors.dart';
import '../../../../config/themes/AppFontWeight.dart';
import '../../../../config/themes/AppTextStyle.dart';
import '../../../../config/themes/app_text_style_base.dart';
import '../../../../utils/helpers/app_helpers.dart';
import 'dart:math';

class TmtResultCard extends StatelessWidget {
  final String title;
  final String duration;
  final String errors;

  const TmtResultCard({
    Key? key,
    required this.title,
    required this.duration,
    required this.errors,
  }) : super(key: key);

  // Función para obtener el factor de escala según el tipo de dispositivo
  double _getScaleFactor() {
    // Obtener el tipo de dispositivo desde DeviceHelper
    final deviceType = DeviceHelper.deviceType;

    // Ajustar el factor de escala según el tipo de tablet
    switch (deviceType) {
      case DeviceType.largeTablet:
        return 1.5;
      case DeviceType.mediumTablet:
        return 1.4;
      case DeviceType.smallTablet:
        return 1.3;
      case DeviceType.largePhone:
        return 1.0;
      case DeviceType.mediumPhone:
        return 0.9;
      case DeviceType.smallPhone:
        return 0.8;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaleFactor = _getScaleFactor();
    final isTablet = DeviceHelper.isTablet;
    final screenWidth = MediaQuery.of(context).size.width;

    final maxCardWidth = isTablet ? screenWidth * 0.7 : double.infinity;

    // Aplicar el factor de escala a los márgenes y espacios
    final verticalMargin = 8.0 * scaleFactor;
    final topPadding = 16.0 * scaleFactor;
    final titleSpacing = 24.0 * scaleFactor;
    final bottomPadding = 16.0 * scaleFactor;
    final labelValueSpacing = 8.0 * scaleFactor;

    return Center(
      child: Container(
        width: maxCardWidth,
        margin: EdgeInsets.symmetric(vertical: verticalMargin),
        decoration: BoxDecoration(
          color: AppColors.secondaryBlue,
          borderRadius: BorderRadius.circular(DeviceHelper.isTablet ? 15 : 10),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: topPadding),
              child: Text(
                title,
                style: TextStyleBase.h1,
              ),
            ),
            SizedBox(height: titleSpacing),
            LayoutBuilder(
              builder: (context, constraints) {
                // Estimar el ancho aproximado de los textos
                final TextPainter durationTextPainter = TextPainter(
                  text: TextSpan(
                    text: 'Duración',
                    style: AppTextStyle.tmtResultCardText,
                  ),
                  textDirection: TextDirection.ltr,
                )..layout();

                final TextPainter errorsTextPainter = TextPainter(
                  text: TextSpan(
                    text: 'Errores',
                    style: AppTextStyle.tmtResultCardText,
                  ),
                  textDirection: TextDirection.ltr,
                )..layout();

                // Calcular el ancho de los textos más un margen para los valores
                final durationWidth =
                    durationTextPainter.width + 20; // +20 para el valor
                final errorsWidth =
                    errorsTextPainter.width + 20; // +20 para el valor

                // Espacio disponible = ancho total - (ancho de textos + valores)
                final availableSpace =
                    constraints.maxWidth - (durationWidth + errorsWidth);

                // Asegurar que availableSpace no sea negativo
                final safeAvailableSpace =
                    availableSpace > 0 ? availableSpace : 0;

                // Dividir el espacio disponible en 5 partes
                final spacePart = safeAvailableSpace / 5;

                // Asignar 2 partes para el padding izquierdo y derecho
                final padding = spacePart * 2;

                return Padding(
                  padding: EdgeInsets.only(
                    left: padding,
                    right: padding,
                    bottom: bottomPadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildColumn('Duración', duration, labelValueSpacing),
                      _buildColumn('Errores', errors, labelValueSpacing),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColumn(String label, String value, double spacing) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyle.tmtResultCardText,
        ),
        SizedBox(height: spacing),
        Text(
          value,
          style: AppTextStyle.tmtResultCardText.copyWith(
            fontWeight: AppFontWeight.semiBold,
          ),
        ),
      ],
    );
  }
}
