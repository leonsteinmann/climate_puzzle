import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../colors/colors.dart';
import '../bloc/puzzle_bloc.dart';

class BackgroundParticlesWidget extends StatefulWidget {

  @override
  _BackgroundParticlesWidgetState createState() => _BackgroundParticlesWidgetState();
}

class _BackgroundParticlesWidgetState extends State<BackgroundParticlesWidget> with SingleTickerProviderStateMixin {

  AnimationController? _controller;
  List<GasParticle> gasParticles = List<GasParticle>.generate(500, (index) => GasParticle());


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
        for (var gas in gasParticles) {
          gas.move(MediaQuery.of(context).size);
        }
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
    const main1 = PuzzleColors.orangeDarkAccent;
    const main2 = PuzzleColors.redDarkAccent;
    const main3 = PuzzleColors.roseDarkAccent;
    const main4 = PuzzleColors.lilaDarkAccent;

    gasParticles.forEach((gas) {
      /// 3D effect by making big particles faster than small
      if(gas.position.dx.isNegative) {
        if(gas.position.dy.isNegative) {
          canvas.drawCircle(gas.position, 2 + (gas.velocity *3), returnPaintFromColor(main1, gas.alpha));
        } else {
          canvas.drawCircle(gas.position, 2 + (gas.velocity *3), returnPaintFromColor(main3, gas.alpha));
        }
      } else {
        if(gas.position.dy.isNegative) {
          canvas.drawCircle(gas.position, 2 + (gas.velocity *3), returnPaintFromColor(main2, gas.alpha));
        } else {
          canvas.drawCircle(gas.position, 2 + (gas.velocity *3), returnPaintFromColor(main4, gas.alpha));
        }
      }

    });
  }

  Paint returnPaintFromColor (Color color, double alpha) {
    return Paint()..color = Color.fromARGB((alpha*255).toInt(), color.red, color.green, color.blue);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class GasParticle {
  GasParticle();
  double alpha = Random().nextDouble();
  double velocity = Random().nextDouble() * 2 + 2;
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