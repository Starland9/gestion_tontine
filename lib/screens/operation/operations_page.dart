import 'package:flutter/material.dart';
import 'package:gestion_tontine/models/operation/operation.dart';
import 'package:gestion_tontine/screens/operation/operation_create_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
      filteredMeetingList = meetingList
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
      appBar: AppBar(
        title: const Text('Operations'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _searchMeeting,
              decoration: const InputDecoration(
                labelText: 'Rechercher une operation',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMeetingList.length,
              itemBuilder: (context, index) {
                final meeting = filteredMeetingList[index];
                final isSelected = selectedMeetings.contains(meeting);

                return ListTile(
                  title: Text(meeting.type),
                  subtitle: Text(meeting.date.toString()),
                  leading: isSelected
                      ? const Icon(Icons.check_circle, color: Colors.blue)
                      : const Icon(Icons.circle_outlined),
                  onTap: () => _toggleMeetingSelection(meeting),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addReunion,
        tooltip: 'effectuer une operation',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addReunion() {
    showDialog(
      context: context,
      builder: (context) => const AddOperationDialog(),
    );
  }
}
