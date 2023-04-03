import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/comments_provider.dart';
import 'hall_a.dart';
import 'hall_b.dart';
import 'hall_c.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CommentsProviders commentsProviders = CommentsProviders();

  @override
  Widget build(BuildContext context) {
    commentsProviders = Provider.of(context);
    commentsProviders.fetchComments();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 160,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HallA(),
                    ),
                  );
                },
                child: const Text('Hall A'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 160,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HallB(),
                    ),
                  );
                },
                child: const Text('Hall B'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 160,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HallC(),
                    ),
                  );
                },
                child: const Text('Hall C'),
              ),
            ),
            const SizedBox(height: 38),
          ],
        ),
      ),
    );
  }
}
