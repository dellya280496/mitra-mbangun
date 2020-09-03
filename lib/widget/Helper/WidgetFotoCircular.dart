import 'package:apps/Utils/values/colors.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class WidgetFotoCircular extends StatelessWidget {
  const WidgetFotoCircular({
    Key key,
    @required this.dataProvider,
    @required this.userFoto,
  }) : super(key: key);

  final DataProvider dataProvider;
  final String userFoto;

  @override
  Widget build(BuildContext context) {
    print(userFoto);
    return CircularPercentIndicator(
      radius: 50.0,
      lineWidth: 5.0,
      animation: true,
      percent: 0.75,
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: AppColors.kRed,
      backgroundColor: AppColors.kDarkYellow,
      center: Container(
          width: 45.0,
          height: 45.0,
          child: ClipOval(
            child: Image.network(
              userFoto == null ? dataProvider.fotoNull : userFoto,
              fit: BoxFit.cover,
              width: 45,
            ),
          )),
    );
  }
}
