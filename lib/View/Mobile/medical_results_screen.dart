import 'package:flutter/material.dart';
import 'package:plasma/View/Widgets/translated_text_widget.dart';

class MedicalTestResultsScreen extends StatelessWidget {
  const MedicalTestResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color color = isDark? Colors.white:Colors.black;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: TranslatedTextWidget(text: 'Medical Test Results'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Table(
          border: TableBorder.all(color: color.withOpacity(0.5)),
          columnWidths: {
            0: FractionColumnWidth(0.5),
            1: FractionColumnWidth(0.25),
            2: FractionColumnWidth(0.25),
          },
          children: [
            buildRow(['Test Name', 'Result', 'Normal Value'], isHeader: true),
            buildRow(['Blood Type', 'O', '']),
            buildRow([
              'HIV',
              '0.346 Negative',
              'Negative: <0.90 ,Borderline:0.90-<1.0 ,positive : >1.0'
            ]),
            buildRow(['Hemoglobin', '13.2', '13 - 17']),
            buildRow(['Hematocrit', '42.5', '41 - 50']),
            buildRow(['Total Protein', '5.9(Low)', '6.6 - 8.3']),
            buildRow(['Albumin', '2.8(Low)', '3.5 - 5.2']),
            buildRow(['Globulin', '2.1(Low)', '2.4 - 3.5']),
            buildRow(['Total bilirubin', '3.7(high)', '0.3 - 1.2']),
            buildRow(['Direct bilirubin', '1.3(high)', '0.0 - 0.2']),
            buildRow(['AST(SGOT)', '119(high)', '0 - 35']),
            buildRow(['ALT(SGPT)', '236(high)', '0 - 45']),
            buildRow(['ALP', '248(high)', '30 - 120']),
            buildRow([
              'HCV Ab',
              '0.04',
              'Less than 0.9 Non reactive, More than 1.0 Reactive'
            ]),
            buildRow([
              'HBS Ag',
              '22.3(positive)',
              'Less than 0.13 Non reactive, More than 0.13 Reactive'
            ]),
          ],
        ),
      ),
    );
  }

  TableRow buildRow(List<String> cells, {bool isHeader = false}) => TableRow(
        children: cells.map(
          (cell) {
            final style = TextStyle(
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                fontSize: 18);
            return Padding(
              padding: const EdgeInsets.all(12),
              child: Center(child: Text(cell,style: style,)),
            );
          },
        ).toList(),
      );
}
