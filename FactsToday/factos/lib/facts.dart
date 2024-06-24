import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:factos/main.dart';
import 'package:intl/intl.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Facts Today',
      home: factos(),
    );
  }
}
class factos extends StatefulWidget {
  const factos({super.key});

  @override
  State<factos> createState() => _factosState();
}

class _factosState extends State<factos> {
  final List<Map> dummy = const [
    {
      'name': 'Loading......',
      'fact': 'Loading......',
      'date': 'Loading......',
    }
  ];

  List<Map> data = [];
  final ScrollController _controller = ScrollController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void fetchFactsFromFirestore() async {
    QuerySnapshot querySnapshot = await firestore.collection('txtData').get();

    setState(() {
      data = querySnapshot.docs.map((doc) {
        return {
          'name': doc['username'],
          'fact': doc['txtVal'],
          'date': doc['timeVal'],
        };
      }).toList();
    });
  }

  String getCurrentDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MM/dd/yyyy');
    return formatter.format(now);
  }

  TextEditingController controllerName = TextEditingController(text: '');
  TextEditingController controllerFact = TextEditingController(text: '');

  void addData() async {
    String name = controllerName.text;
    String fact = controllerFact.text;

    if (name.isNotEmpty && fact.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('txtData').add({
          'username': name,
          'txtVal': fact,
          'timeVal': getCurrentDate(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data added successfully!')),
        );
        controllerFact.clear();
        controllerName.clear();
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add data: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  Future<void> inputForm() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 24, 25, 26),
          title: const Text(
            'Share a new fact',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Color.fromARGB(255, 36, 37, 38),
                  ),
                  child: TextField(
                    autofocus: true,
                    controller: controllerName,
                    maxLines: null,
                    cursorColor: Colors.white,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[200]),
                    decoration: const InputDecoration(
                      hintText: 'Enter your name',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 105, 111, 116)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Color.fromARGB(255, 36, 37, 38),
                  ),
                  child: TextField(
                    controller: controllerFact,
                    minLines: 3, // Set this
                    maxLines: 6, // and this
                    keyboardType: TextInputType.multiline,
                    cursorColor: Colors.white,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Share a fact',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 105, 111, 116)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextButton(
                        onPressed: () {
                          addData();
                        },
                        child: const Text(
                          'Share',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ))),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.red[800],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                                  controllerFact.clear();
                                  controllerName.clear();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )))
              ],
            ),
          ),
        );
      },
    );
  }

  void navigateHome() {
    Navigator.pop(context, MaterialPageRoute(builder: (context) {
      return const MyApp();
    }));
  }

  void scrollToTop() {
    _controller.animateTo(
      _controller.position.minScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    super.initState();
    fetchFactsFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 25, 26),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: navigateHome,
          highlightColor: const Color.fromARGB(255, 68, 73, 75),
          child: const Text(
            'Home',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 36, 37, 38),
      ),
      body: ListView.builder(
        controller: _controller,
        itemCount: data.isNotEmpty ? data.length : dummy.length,
        itemBuilder: (context, index) {
          var item = data.isNotEmpty ? data[index] : dummy[index];
          return Column(
            children: [
              const SizedBox(height: 15),
              FactCard(
                fact: data.isNotEmpty
                    ? {
                        'name': item['name'],
                        'fact': item['fact'],
                        'date': item['date'].toString()
                      }
                    : item,
              ),
              const SizedBox(height: 5),
            ],
          );
        },
      ),
      floatingActionButton: SizedBox(
        height: 130,
        width: 50,
        child: Column(
          children: [
            FloatingActionButton(
              heroTag: 'add',
              onPressed: null,
              backgroundColor: const Color.fromARGB(255, 49, 51, 52),
              child: IconButton(
                onPressed: inputForm,
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              heroTag: 'gototop',
              onPressed: scrollToTop,
              backgroundColor: const Color.fromARGB(255, 49, 51, 52),
              child: const Icon(
                Icons.arrow_upward_sharp,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FactCard extends StatelessWidget {
  final Map fact;
  const FactCard({
    required this.fact,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 36, 37, 38),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color.fromARGB(255, 49, 51, 52),
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 36, 37, 38),
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://factos.vercel.app/_next/image?url=%2Fdonkey.png&w=96&q=75',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    fact['name']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    fact['date']!,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Text(
                fact['fact']!,
                style: const TextStyle(
                  color: Colors.white,
                  height: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
