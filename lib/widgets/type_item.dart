import 'package:flutter/material.dart';

class TypeItem extends StatefulWidget {
  final String name;
  final Widget destinationPage;

  const TypeItem({
    super.key,
    required this.name,
    required this.destinationPage,
  });

  @override
  _TypeItemState createState() => _TypeItemState();
}

class _TypeItemState extends State<TypeItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget.destinationPage),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Positioned(
                  top: _animation.value * 10,
                  child: Opacity(
                    opacity: 1 - _animation.value,
                    child: const Icon(
                      Icons.local_fire_department,
                      color: Colors.blue,
                      size: 100,
                    ),
                  ),
                );
              },
            ),
            InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => widget.destinationPage),
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color.fromARGB(255, 4, 32, 61), Color(0xFF42A5F5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    widget.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}