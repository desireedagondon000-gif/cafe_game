import 'package:flutter/material.dart';
import 'start_view.dart';

class ResultView extends StatefulWidget {
  final int score;

  const ResultView({super.key, required this.score});

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Modular Widget: Title
  Widget _buildTitle() {
    return const Text(
      "Amazing Work!",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Color(0xFFE91E63), // Pink shade
      ),
    );
  }

  // Modular Widget: Score
  Widget _buildScore() {
    return Text(
      "You served ${widget.score} orders",
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: Color(0xFFF06292), // Pink shade
      ),
    );
  }

  // Modular Widget: Button (Play Again only)
  Widget _buildButton(double spacing) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const StartView()),
          (route) => false,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF48FB1),
        padding: EdgeInsets.symmetric(
          horizontal: spacing * 2,
          vertical: spacing / 1.2,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: const Text(
        "Play Again",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double spacing = 30; // constant spacing

    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spacing,
                  vertical: spacing * 1.3,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF8BBD0), Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x80E0E0E0),
                      blurRadius: 12,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Wrap texts in Flexible to avoid overflow
                    Flexible(child: _buildTitle()),
                    SizedBox(height: spacing),
                    Flexible(child: _buildScore()),
                    SizedBox(height: spacing * 1.5),
                    _buildButton(spacing),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
