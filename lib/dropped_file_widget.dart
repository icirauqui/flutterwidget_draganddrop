import 'package:flutter/material.dart';
import 'dropped_file.dart';

class DroppedFileWidget extends StatelessWidget {
  final DroppedFile? file;

  const DroppedFileWidget({
    super.key,
    required this.file,
  });

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildImage(),
          if (file != null) buildFileDetails(file!),
        ],
      );

  Widget buildImage() {
    if (file == null) return buildEmptyFile('No File');
    return Image.network(
      file!.url,
      width: 120,
      height: 120,
      fit: BoxFit.cover,
      errorBuilder: (context, error, _) => buildEmptyFile('No Preview'),
    );
  }

  Widget buildEmptyFile(String text) => Container(
        width: 120,
        height: 120,
        color: Colors.blue.shade300,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  Widget buildFileDetails(DroppedFile file) {
    const style = TextStyle(fontSize: 20);

    return Container(
        margin: const EdgeInsets.only(left: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(file.name, style: style.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(file.mime, style: style),
            const SizedBox(height: 8),
            Text(file.size, style: style),
          ],
        ));
  }
}
