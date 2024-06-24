import 'package:flutter/material.dart';
import 'package:factos/facts.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
    apiKey: "",
    appId: "",
    messagingSenderId: "",
    projectId: "",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Facts Today',
      home: Factos(),
    );
  }
}

class Factos extends StatefulWidget {
  const Factos({super.key});

  @override
  State<Factos> createState() => _FactosState();
}

class _FactosState extends State<Factos> {
  void abc() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const factos();
    }));
  }

  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 38, 45, 58),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/a.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Facts Today',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Share a fact that you learned today.',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(
                height: 30,
              ),
              MouseRegion(
                onEnter: (_) {
                  setState(() {
                    isHovered = true;
                  });
                },
                onExit: (_) {
                  setState(() {
                    isHovered = false;
                  });
                },
                child: GestureDetector(
                  onTap: abc,
                  child: Container(
                    width: 200,
                    height: 37,
                    decoration: BoxDecoration(
                        color: isHovered
                            ? const Color.fromARGB(255, 38, 45, 58)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white, width: 2)),
                    child: Center(
                      child: Text(
                        'Start Sharing',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: isHovered ? Colors.white : Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
