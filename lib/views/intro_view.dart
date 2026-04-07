import 'package:flutter/material.dart';
import 'game_view.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Responsive sizes
    double iconSize = screenWidth < 400 ? 24 : 30;
    double titleFontSize = screenWidth < 400 ? 20 : 26;
    double textFontSize = screenWidth < 400 ? 14 : 18;
    double buttonFontSize = screenWidth < 400 ? 16 : 20;
    double spacing = screenWidth < 400 ? 16 : 25;

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
                vertical: spacing * 1.3,
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
                  // Title with icon
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.local_cafe,
                        size: iconSize,
                        color: Colors.pink.shade400,
                      ),
                      SizedBox(width: spacing / 2),
                      Flexible(
                        child: Text(
                          "Bloom Brew Café",
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink.shade400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spacing),
                  // Instruction text
                  Flexible(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: textFontSize,
                          color: Colors.pink.shade400,
                        ),
                        children: [
                          const TextSpan(
                            text:
                                "Hi! I'm Lily, the manager of Bloom Brew Café.\n\n"
                                "Your job is to serve the correct orders.\n"
                                "As you improve, orders get harder!\n\n",
                          ),
                          WidgetSpan(
                            child: Icon(
                              Icons.favorite,
                              size: textFontSize,
                              color: Colors.pink.shade300,
                            ),
                          ),
                          const TextSpan(text: " Good luck!"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: spacing),
                  // Start button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const GameView()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade200,
                      padding: EdgeInsets.symmetric(
                        horizontal: spacing * 1.5,
                        vertical: spacing / 1.2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      "I'm Ready!",
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
