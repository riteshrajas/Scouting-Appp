
import 'package:flutter/material.dart';

import 'Auton.dart';
import 'EndGame.dart';
import 'tele_operated.dart';

class TemplateEditor extends StatefulWidget {
  const TemplateEditor({super.key});

  @override
  TemplateEditorState createState() => TemplateEditorState();
}

class TemplateEditorState extends State<TemplateEditor> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Specify the number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Template Editor'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Auto'),
              Tab(text: 'TeleOp'),
              Tab(text: 'EndGame'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                // Save functionality here
              },
            ),
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                // Copy functionality here
              },
            ),
          ],
        ),
        body:  const TabBarView(
          children: [
            // Auto Tab
            Center(child: AutonBuilder()),
            // TeleOp Tab
            Center(child: TeleOPBuilder()),
            // EndGame Tab
            Center(child: EndGameBuilder()),
          ],
        ),
      ),
    );
  }
}