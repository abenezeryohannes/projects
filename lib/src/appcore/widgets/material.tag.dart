import 'package:flutter/material.dart';
import 'package:material_tag_editor/tag_editor.dart';

class MaterialTag extends StatefulWidget {
  const MaterialTag(
      {super.key,
      required this.label,
      required this.onDeleted,
      required this.values});

  final String label;
  final ValueChanged<int> onDeleted;
  final List<String> values;
  @override
  State<MaterialTag> createState() => _MaterialTagState();
}

class _MaterialTagState extends State<MaterialTag> {
  @override
  Widget build(BuildContext context) {
    return TagEditor(
      length: widget.values.length,
      delimiters: [',', ' '],
      hasAddButton: true,
      inputDecoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Hint Text...',
      ),
      onTagChanged: (newValue) {
        setState(() {
          widget.values.add(newValue);
        });
      },
      tagBuilder: (context, index) => _chip(
        index: index,
        label: widget.values[index],
        onDeleted: widget.onDeleted,
      ),
    );
  }

  Widget _chip(
      {required String label,
      required ValueChanged<int> onDeleted,
      required int index}) {
    return Chip(
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label),
      deleteIcon: const Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}
