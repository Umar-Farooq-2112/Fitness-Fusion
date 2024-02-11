import 'package:flutter/material.dart';

class WeightHeightSelectorDialog extends StatefulWidget {
  final double initialWeight;
  final int initialHeightFt;
  final double initialHeightInch;
  final Function(double, int, double) onWeightHeightChanged;

  WeightHeightSelectorDialog({
    required this.initialWeight,
    required this.initialHeightFt,
    required this.initialHeightInch,
    required this.onWeightHeightChanged,
  });

  @override
  _WeightHeightSelectorDialogState createState() =>
      _WeightHeightSelectorDialogState();
}

class _WeightHeightSelectorDialogState
    extends State<WeightHeightSelectorDialog> {
  late double weight;
  late int heightFt;
  late double heightInch;

  @override
  void initState() {
    super.initState();
    weight = widget.initialWeight;
    heightFt = widget.initialHeightFt;
    heightInch = widget.initialHeightInch;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Weight'),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weight.toStringAsFixed(1),
            ),
            SizedBox(
              width: 2.0,
            ),
            Text('kg'),
          ],
        ),
        Slider(
          min: 10,
          max: 200,
          value: weight,
          onChanged: (value) {
            setState(() {
              weight = double.parse(value.toStringAsFixed(1));
              widget.onWeightHeightChanged(weight, heightFt, heightInch);
            });
          },
        ),
        Text('Height'),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              heightFt.toString(),
            ),
            SizedBox(
              width: 2.0,
            ),
            Text('Ft'),
          ],
        ),
        Slider(
          min: 0,
          max: 20,
          value: heightFt.toDouble(),
          onChanged: (value) {
            setState(() {
              heightFt = value.toInt();
              widget.onWeightHeightChanged(weight, heightFt, heightInch);
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              heightInch.toStringAsFixed(1),
            ),
            SizedBox(
              width: 2.0,
            ),
            Text('Inches'),
          ],
        ),
        Slider(
          min: 0,
          max: 12,
          value: heightInch,
          onChanged: (value) {
            setState(() {
              heightInch = double.parse(value.toStringAsFixed(1));
              widget.onWeightHeightChanged(weight, heightFt, heightInch);
            });
          },
        ),
      ],
    );
  }
}
