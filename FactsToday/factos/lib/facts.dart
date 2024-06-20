import 'package:flutter/material.dart';
import 'package:factos/main.dart';

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
  final List<Map<String, String>> factsList = const [
    {
      'name': 'Ankit Khanal',
      'fact': 'I am learning flutter:)',
      'date': '2081/03/02',
    },
    {
      'name': 'Prajina Adhikari',
      'fact': 'I am learning flutter:)',
      'date': '2081/03/02',
    },
    {
      'name': 'Sujan Puri',
      'fact': 'I am learning flutter:)',
      'date': '2081/03/02',
    },
    {
      'name': 'Hemanta Khatiwada',
      'fact': 'I am learning flutter:)',
      'date': '2081/03/02',
    },
    {
      'name': 'Hridayadev Dhungana',
      'fact': 'I am learning flutter:)',
      'date': '2081/03/02',
    },
    {
      'name': 'Nishan  Gautam',
      'fact': 'I am learning flutter:)',
      'date': '2081/03/02',
    },
    {
      'name': 'Anil Thapa',
      'fact': 'I am learning flutter:)',
      'date': '2081/03/02',
    }
  ];

  final List<Map<String, String>> commentsList = [
    {
      'comment': 'This is comment 1',
    },
    {
      'comment': 'This is comment 2',
    },
    {
      'comment': 'This is comment 3',
    },
    {
      'comment': 'This is comment 4',
    },
    {
      'comment': 'This is comment 5',
    },
  ];

  bool hasUserLiked = false;
  final ScrollController _controller = ScrollController();

  int likeCount = 0;
  void increaseLikes() {
    if (hasUserLiked) {
      setState(() {
        likeCount--;
      });
    } else {
      setState(() {
        likeCount++;
      });
    }
    setState(() {
      hasUserLiked = !hasUserLiked;
    });
  }

  var a = false;
  void ntg() {
    a = true;
  }

  Future<void> _showCommentsDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user can tap outside to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 24, 25, 26),
          title: const Text('Comments',
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center),
          content: SizedBox(
            height: 250,
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: commentsList.length,
              itemBuilder: (context, index) {
                return Column(children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 49, 51, 52),
                            width: 2),
                        color: const Color.fromARGB(255, 36, 37, 38),
                        borderRadius: BorderRadius.circular(10)),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                'https://avatars.githubusercontent.com/u/134664758?v=4',
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 200,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${factsList[index]['name']}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${commentsList[index]['comment']!}',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ]),
                            ),
                            const SizedBox(
                              width: 35,
                            ),
                            InkWell(
                              onTap: increaseLikes,
                              child: const Icon(
                                Icons.thumb_up,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '$likeCount',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ]);
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 25, 26),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            hoverColor: const Color.fromARGB(255, 49, 51, 52),
            onPressed: () {},
            icon: const Row(children: [
              Icon(
                Icons.login,
                color: Colors.white,
                size: 30,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ]),
          ),
          const SizedBox(width: 10)
        ],
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
        itemCount: factsList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const SizedBox(height: 15),
              FactCard(
                fact: factsList[index],
                likeCount: likeCount,
                onLikePressed: increaseLikes,
                onCommentPressed: _showCommentsDialog,
              ),
              const SizedBox(height: 5),
            ],
          );
        },
      ),
      floatingActionButton: Container(
        height: 50,
        width: 50,
        child: FloatingActionButton(
          onPressed: scrollToTop,
          backgroundColor: const Color.fromARGB(255, 49, 51, 52),
          child: const Icon(
            Icons.arrow_upward_sharp,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}

class FactCard extends StatelessWidget {
  final Map<String, String> fact;
  final int likeCount;
  final VoidCallback onLikePressed;
  final VoidCallback onCommentPressed;

  const FactCard({
    required this.fact,
    required this.likeCount,
    required this.onLikePressed,
    required this.onCommentPressed,
    Key? key,
  }) : super(key: key);

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
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/134664758?v=4',
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
            Row(
              children: [
                IconButton(
                  onPressed: onLikePressed,
                  icon: const Icon(
                    Icons.thumb_up,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "$likeCount",
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: onCommentPressed,
                  child: const Icon(
                    Icons.comment,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
