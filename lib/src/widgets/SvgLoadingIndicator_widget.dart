import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fweather/src/constants/color.dart';

class SvgLoadingIndicator extends StatefulWidget {
  final double size;
  final String svgPath;

  const SvgLoadingIndicator({
    Key? key,
    this.size = 100.0,
    required this.svgPath,
  }) : super(key: key);

  @override
  _SvgLoadingIndicatorState createState() => _SvgLoadingIndicatorState();
}

class _SvgLoadingIndicatorState extends State<SvgLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // Animasyon tekrar eder
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backroundblue, // Arka plan rengi mor
      body: Center(
        child: SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Arka plan rengi (SVG olmadan)
              Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  color: Colors.white
                      .withOpacity(0.1), // Arka plan rengi (daha hafif bir ton)
                  shape: BoxShape.circle, // Yuvarlak arka plan
                ),
              ),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return ClipRect(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      heightFactor:
                          _controller.value, // SVG'nin zamanla dolması
                      child: SvgPicture.asset(
                        widget.svgPath,
                        width: widget.size * 0.6,
                        height: widget.size * 0.6,
                        // ignore: deprecated_member_use
                        color: Colors.blue, // Doldurma rengi
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
