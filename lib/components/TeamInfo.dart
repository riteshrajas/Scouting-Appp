import 'package:flutter/material.dart';

class TeamInfo extends StatelessWidget {
  final String assignedTeam;
  final String assignedStation;
  final String allianceColor;
  final VoidCallback onPressed;

  TeamInfo({
    required this.assignedTeam,
    required this.assignedStation,
    required this.allianceColor,
    required this.onPressed,
  });

  // Convert this widget to a map for saving
  Map<String, dynamic> toJson() {
    return {
      'assignedTeam': assignedTeam,
      'assignedStation': assignedStation,
      'allianceColor': allianceColor,
    };
  }

  // Create a widget from a map
  factory TeamInfo.fromJson(Map<String, dynamic> json, VoidCallback onPressed) {
    return TeamInfo(
      assignedTeam: json['assignedTeam'],
      assignedStation: json['assignedStation'],
      allianceColor: json['allianceColor'],
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 100, // Set minimum width
          minHeight: 50, // Set minimum height
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.category,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    assignedTeam,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$allianceColor Alliance, Station $assignedStation',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text(
                  'START',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
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
