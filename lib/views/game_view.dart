import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/order_card.dart';
import '../widgets/menu_button.dart';
import 'result_view.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  int score = 0;
  int maxScore = 30;

  List<String> currentOrder = [];
  List<String> selectedItems = [];
  Map<String, dynamic> currentCustomer = {};

  Timer? _timer;
  int _timeLeft = 10;
  final Random _rand = Random();

  @override
  void initState() {
    super.initState();
    generateOrder();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  int getRandomOrderCount() {
    if (score < 5) {
      return 1;
    }
    if (score < 10) {
      return _rand.nextInt(2) + 1;
    }
    if (score < 20) {
      return _rand.nextInt(3) + 1;
    }
    return _rand.nextInt(3) + 1;
  }

  void startTimer() {
    _timer?.cancel();
    _timeLeft = (score >= 20) ? 5 : 10;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeLeft--;
      });

      if (_timeLeft <= 0) {
        timer.cancel();
        showMessage("Time's up!", success: false);
        Future.delayed(const Duration(milliseconds: 700), () {
          setState(() {
            resetScore();
          });
        });
      }
    });
  }

  void generateOrder() {
    _timer?.cancel();
    selectedItems.clear();
    currentOrder.clear();

    currentCustomer =
        Constants.customers[_rand.nextInt(Constants.customers.length)];

    int orderCount = getRandomOrderCount();
    for (int i = 0; i < orderCount; i++) {
      var item = Constants.menu[_rand.nextInt(Constants.menu.length)];
      currentOrder.add(item["name"]);
    }

    startTimer();
    setState(() {});
  }

  void selectItem(String item) {
    selectedItems.add(item);

    Map<String, int> orderCount = {};
    Map<String, int> selectedCount = {};

    for (var i in currentOrder) {
      orderCount[i] = (orderCount[i] ?? 0) + 1;
    }
    for (var i in selectedItems) {
      selectedCount[i] = (selectedCount[i] ?? 0) + 1;
    }

    for (var key in selectedCount.keys) {
      if ((orderCount[key] ?? 0) < selectedCount[key]!) {
        _timer?.cancel();
        showMessage("Wrong order!", success: false);
        Future.delayed(const Duration(milliseconds: 700), () {
          setState(() {
            resetScore();
          });
        });
        return;
      }
    }

    if (selectedItems.length == currentOrder.length) {
      checkOrder();
    } else {
      setState(() {});
    }
  }

  void checkOrder() {
    _timer?.cancel();

    List<String> sortedOrder = List.from(currentOrder)..sort();
    List<String> sortedSelected = List.from(selectedItems)..sort();

    if (sortedOrder.toString() == sortedSelected.toString()) {
      setState(() {
        score++;
        selectedItems.clear();
      });
      showMessage("Correct!", success: true);
    } else {
      showMessage("Wrong order!", success: false);
      Future.delayed(const Duration(milliseconds: 700), () {
        setState(() {
          resetScore();
        });
      });
      return;
    }

    if (score >= maxScore) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ResultView(score: score)),
      );
      return;
    }

    generateOrder();
  }

  void resetScore() {
    score = 0;
    selectedItems.clear();
    generateOrder();
  }

  void showMessage(String msg, {bool success = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(milliseconds: 700),
        backgroundColor: success ? Colors.green.shade300 : Colors.red.shade300,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double maxContentWidth = screenWidth < 600
        ? screenWidth * 0.95
        : screenWidth < 1200
        ? 600
        : 700;

    double padding = screenWidth < 600 ? 12 : 20;
    double fontSize = screenWidth < 600 ? 14 : 18;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        elevation: 4,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.local_cafe, size: fontSize, color: Colors.white),
            SizedBox(width: padding / 2),
            Text(
              "Bloom Brew Café",
              style: TextStyle(
                fontSize: fontSize + 4,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxContentWidth,
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _scoreTimerBox(
                            "Score: $score",
                            Colors.pink,
                            fontSize,
                          ),
                          _scoreTimerBox(
                            "Time: $_timeLeft",
                            Colors.red,
                            fontSize,
                          ),
                        ],
                      ),
                      SizedBox(height: padding),
                      OrderCard(
                        customerName: currentCustomer["name"] ?? "",
                        customerIcon: currentCustomer["icon"] ?? Icons.person,
                        customerColor: currentCustomer["color"] ?? Colors.pink,
                        orders: currentOrder,
                        selectedItems: selectedItems,
                      ),
                      SizedBox(height: padding),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          double spacing = constraints.maxWidth * 0.03;
                          double buttonWidth =
                              constraints.maxWidth / 4 - spacing;
                          return Wrap(
                            spacing: spacing,
                            runSpacing: spacing,
                            alignment: WrapAlignment.center,
                            children: Constants.menu.map((item) {
                              return SizedBox(
                                width: buttonWidth < 80 ? 80 : buttonWidth,
                                child: MenuButton(
                                  name: item["name"],
                                  icon: item["icon"],
                                  isSelected: selectedItems
                                      .where((i) => i == item["name"])
                                      .isNotEmpty,
                                  onTap: () {
                                    selectItem(item["name"]);
                                  },
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                      SizedBox(height: padding),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _scoreTimerBox(String text, Color borderColor, double fontSize) {
    return Container(
      padding: EdgeInsets.all(fontSize / 1.5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(text, style: TextStyle(fontSize: fontSize)),
    );
  }
}
