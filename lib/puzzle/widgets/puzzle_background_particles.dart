import 'dart:html';
import 'dart:math';
import 'package:flutter/material.dart';

class BackgroundParticlesWidget extends StatefulWidget {

  @override
  _BackgroundParticlesWidgetState createState() => _BackgroundParticlesWidgetState();
}

class _BackgroundParticlesWidgetState extends State<BackgroundParticlesWidget> with SingleTickerProviderStateMixin {

  AnimationController? _controller;
  List<GasParticle> gasParticles = List<GasParticle>.generate(100, (index) => GasParticle());


  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1),
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller!,
      builder: (_, __) {
        gasParticles.forEach((gas) => gas.move(MediaQuery.of(context).size));
        return CustomPaint(
          painter: BackgroundParticlesPainter(gasParticles),
        );
      },
    );
  }
}

class BackgroundParticlesPainter extends CustomPainter {

  BackgroundParticlesPainter(this.gasParticles);

  List<GasParticle> gasParticles;

  @override
  void paint(Canvas canvas, Size size) {
    final whitePaint = Paint()..color = Colors.orange;

    gasParticles.forEach((gas) =>
        canvas.drawCircle(gas.position, 20, whitePaint));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}

class GasParticle {
  GasParticle();
  double velocity = Random().nextDouble() * 4 + 2;
  Offset position = Offset(Random().nextDouble(), Random().nextDouble());
  Offset direction = Random().nextBool()
      ? Offset(
    Random().nextDouble(),
    Random().nextBool() ? -0.0 : 1.0,
  )
      : Offset(
    Random().nextBool() ? -0.0 : 1.0,
    Random().nextDouble(),
  );


  void move(Size contextSize) {
    position = Offset(
      position.dx + ((1 - velocity) * 0.5 + velocity * direction.dx),
      position.dy + ((1 - velocity) * 0.5 + velocity * direction.dy),
    );

    if (position.dx > contextSize.width/2 || position.dy > contextSize.height/2) {
      position = Offset(Random().nextDouble(), Random().nextDouble());
    }
    if (position.dx < contextSize.width/2*-1 || position.dy < contextSize.height/2*-1) {
      position = Offset(Random().nextDouble() * -1, Random().nextDouble() * -1);
    }
  }

}