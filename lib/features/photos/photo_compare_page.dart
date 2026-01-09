import 'package:flutter/material.dart';

import 'package:weightvault/core/ui/widgets.dart';
import 'package:weightvault/core/utils/local_image.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class PhotoComparePage extends StatefulWidget {
  const PhotoComparePage({required this.before, required this.after, super.key});

  final PhotoEntry before;
  final PhotoEntry after;

  @override
  State<PhotoComparePage> createState() => _PhotoComparePageState();
}

class _PhotoComparePageState extends State<PhotoComparePage> {
  double _value = 0.5;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(strings.photoCompareTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                return Stack(
                  children: [
                    _buildImage(widget.before),
                    ClipRect(
                      clipper: _SliderClipper(_value * width),
                      child: _buildImage(widget.after),
                    ),
                    Positioned(
                      left: _value * width - 12,
                      top: 0,
                      bottom: 0,
                      child: Container(width: 4, color: Colors.white),
                    ),
                  ],
                );
              },
            ),
          ),
          Slider(
            value: _value,
            onChanged: (value) => setState(() => _value = value),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(PhotoEntry entry) {
    if (entry.localPath != null && localFileExists(entry.localPath!)) {
      return buildLocalImage(
        entry.localPath!,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }
    if (entry.storageUrl != null) {
      return Image.network(entry.storageUrl!, fit: BoxFit.cover, width: double.infinity);
    }
    return const ColoredBox(color: Colors.black12);
  }
}

class _SliderClipper extends CustomClipper<Rect> {
  _SliderClipper(this.width);

  final double width;

  @override
  Rect getClip(Size size) => Rect.fromLTWH(0, 0, width, size.height);

  @override
  bool shouldReclip(covariant _SliderClipper oldClipper) => oldClipper.width != width;
}
