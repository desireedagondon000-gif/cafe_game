import 'package:flutter/material.dart';
import 'intro_view.dart';

class StartView extends StatelessWidget {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Responsive sizing
    double iconSize = screenWidth < 400 ? 70 : 90;
    double titleFontSize = screenWidth < 400 ? 24 : 34;
    double buttonFontSize = screenWidth < 400 ? 16 : 20;
    double spacing = screenWidth < 400 ? 20 : 30;

    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: FractionallySizedBox(
            widthFactor: screenWidth < 500 ? 0.9 : 0.6,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: spacing,
                vertical: spacing * 1.5,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pink.shade100, Colors.white],
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
                  // Icon
                  Icon(
                    Icons.local_cafe,
                    size: iconSize,
                    color: Colors.pink.shade400,
                  ),
                  SizedBox(height: spacing),
                  // Title text
                  Flexible(
                    child: Text(
                      "Bloom Brew Café",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink.shade400,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  SizedBox(height: spacing * 2),
                  // Start button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const IntroView()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade200,
                      padding: EdgeInsets.symmetric(
                        horizontal: spacing * 1.5,
                        vertical: spacing / 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      "Start!",
                      style: TextStyle(
                        fontSize: buttonFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
