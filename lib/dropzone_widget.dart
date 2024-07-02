import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'dropped_file.dart';
import 'package:dotted_border/dotted_border.dart';

class DropzoneWidget extends StatefulWidget {
  final ValueChanged<DroppedFile> onDroppedFile;

  const DropzoneWidget({super.key, required this.onDroppedFile});

  @override
  State<DropzoneWidget> createState() => _DropzoneWidgetState();
}

class _DropzoneWidgetState extends State<DropzoneWidget> {
  late DropzoneViewController controller;
  bool isHighlighted = false;

  @override
  Widget build(BuildContext context) {
    final Color colorBackground = isHighlighted ? Colors.blue : Colors.green;
    final Color colorButton =
        isHighlighted ? Colors.blue.shade300 : Colors.green.shade300;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        color: colorBackground,
        child: DottedBorder(
          borderType: BorderType.RRect,
          color: Colors.white,
          strokeWidth: 3,
          padding: EdgeInsets.zero,
          dashPattern: const [8, 4],
          radius: const Radius.circular(10),
          child: Stack(
            children: [
              DropzoneView(
                onCreated: (controller) => this.controller = controller,
                onDrop: _acceptFile,
                onHover: () => setState(() {
                  isHighlighted = true;
                }),
                onLeave: () => setState(() {
                  isHighlighted = false;
                }),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.cloud_upload,
                        size: 80, color: Colors.white),
                    const Text(
                      "Drop Files here",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(colorButton),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        final events = await controller.pickFiles();
                        if (events.isEmpty) return;
                        _acceptFile(events.first);
                      },
                      icon: const Icon(Icons.search, size: 32),
                      label: const Text(
                        'Choose Files',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _acceptFile(dynamic event) async {
    final name = event.name;
    final mime = await controller.getFileMIME(event);
    final bytes = await controller.getFileSize(event);
    final url = await controller.createFileUrl(event);
    //print('Name: $name');
    //print('MIME: $mime');
    //print('Size: $bytes');
    //print('URL: $url');

    final droppedFile = DroppedFile(
      url: url,
      name: name,
      mime: mime,
      bytes: bytes,
    );

    widget.onDroppedFile(droppedFile);

    setState(() => isHighlighted = false);
  }
}
