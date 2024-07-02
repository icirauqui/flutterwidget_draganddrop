import 'package:flutter/material.dart';
import 'dropzone_widget.dart';
import 'dropped_file_widget.dart';
import 'dropped_file.dart';

class DragAndDropWidget extends StatefulWidget {
  const DragAndDropWidget(
      {super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  State<DragAndDropWidget> createState() => _DragAndDropWidgetState();
}

class _DragAndDropWidgetState extends State<DragAndDropWidget> {
  DroppedFile? file;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DroppedFileWidget(file: file),
          const SizedBox(height: 16),
          SizedBox(
            height: widget.height,
            width: widget.width,
            child: DropzoneWidget(
              onDroppedFile: (file) => setState(() => this.file = file),
            ),
          ),
        ],
      ),
    );
  }
}
