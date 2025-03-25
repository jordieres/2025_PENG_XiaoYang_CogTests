import 'package:flutter/material.dart';
import '../../../../config/themes/AppColors.dart';
import '../../../../config/themes/AppFontWeight.dart';
import '../../../../config/themes/AppTextStyle.dart';
import '../../../../config/themes/app_text_style_base.dart';

class TmtResultCard extends StatelessWidget {
  final String title;
  final String duration;
  final String errors;
  final String sessions;

  const TmtResultCard({
    Key? key,
    required this.title,
    required this.duration,
    required this.errors,
    required this.sessions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.secondaryBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              title,
              style: TextStyleBase.h1,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildColumn(
                    'Duración', duration), //TODO change translation
              ),
              SizedBox(width: 12),
              Expanded(
                child:
                    _buildColumn('Errores', errors), //TODO change translation
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildColumn(
                    'Sesiones', sessions), //TODO change translation
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildColumn(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyle.tmtResultCardText,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTextStyle.tmtResultCardText.copyWith(
            fontWeight: AppFontWeight.semiBold,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
