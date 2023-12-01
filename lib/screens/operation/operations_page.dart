import 'package:flutter/material.dart';
import 'package:gestion_tontine/models/operation/operation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class OperationsPage extends StatefulWidget {
  const OperationsPage({super.key});

  @override
  State<OperationsPage> createState() => _OperationsPageState();
}

class _OperationsPageState extends State<OperationsPage> {
  List<Operation> selectedMeetings = [];
  List<Operation> meetingList = [];
  List<Operation> filteredMeetingList = [];

  @override
  void initState() {
    super.initState();
    meetingList = Hive.box<Operation>('operations').values.toList();
    filteredMeetingList = meetingList;
  }

  void _searchMeeting(String query) {
    setState(() {
      filteredMeetingList = meetingList.reversed
          .where((meeting) =>
              meeting.type.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _toggleMeetingSelection(Operation meeting) {
    setState(() {
      if (selectedMeetings.contains(meeting)) {
        selectedMeetings.remove(meeting);
      } else {
        selectedMeetings.add(meeting);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 16),
          const Text(
            "Historique des Transactions",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMeetingList.length,
              itemBuilder: (context, index) {
                final meeting = filteredMeetingList[index];
                final isSelected = selectedMeetings.contains(meeting);

                return ListTile(
                  title: Text(
                      "${meeting.type.toUpperCase()} de ${meeting.amount} FCFA"),
                  subtitle: Text(DateFormat('dd/MM/yyyy').format(meeting.date)),
                  leading: meeting.type == "depot"
                      ? const Icon(
                          Icons.add,
                          color: Colors.green,
                        )
                      : const Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                  onTap: () => _toggleMeetingSelection(meeting),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
