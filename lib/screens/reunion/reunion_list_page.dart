import 'package:flutter/material.dart';
import 'package:gestion_tontine/models/reunion/reunion.dart';
import 'package:gestion_tontine/models/user/user.dart';
import 'package:gestion_tontine/screens/reunion/reunion_create_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MeetingListPage extends StatefulWidget {
  const MeetingListPage({super.key, required this.user});

  final User user;

  @override
  State<MeetingListPage> createState() => _MeetingListPageState();
}

class _MeetingListPageState extends State<MeetingListPage> {
  List<Reunion> selectedMeetings = [];
  List<Reunion> meetingList = [];
  List<Reunion> filteredMeetingList = [];

  @override
  void initState() {
    super.initState();
    meetingList = Hive.box<Reunion>('reunions').values.toList();

    if (!widget.user.isAdmin) {
      meetingList = meetingList
          .where((meeting) => meeting.participants.contains(widget.user))
          .toList();
    }
    filteredMeetingList = meetingList;
    super.initState();
  }

  void _searchMeeting(String query) {
    setState(() {
      filteredMeetingList = meetingList
          .where((meeting) =>
              meeting.cause.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _toggleMeetingSelection(Reunion meeting) {
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
    final box = Hive.box<Reunion>('reunions');

    return Scaffold(
      appBar: AppBar(
        title: widget.user.isAdmin
            ? const Text('Gestion des reunions')
            : const Text("Mes reunions"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _searchMeeting,
              decoration: const InputDecoration(
                labelText: 'Rechercher une Reunion',
              ),
            ),
          ),
          ValueListenableBuilder<Box<Reunion>>(
              valueListenable: box.listenable(),
              builder: (context, box, _) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: filteredMeetingList.length,
                    itemBuilder: (context, index) {
                      final meeting = filteredMeetingList[index];
                      final isSelected = selectedMeetings.contains(meeting);

                      return ListTile(
                        title: Text(meeting.cause),
                        subtitle: Text(meeting.date.toString()),
                        leading: isSelected
                            ? const Icon(Icons.check_circle, color: Colors.blue)
                            : const Icon(Icons.circle_outlined),
                        onTap: () => _toggleMeetingSelection(meeting),
                        trailing: widget.user.isAdmin
                            ? IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  box.deleteAt(index);
                                },
                              )
                            : null,
                      );
                    },
                  ),
                );
              })
        ],
      ),
      floatingActionButton: widget.user.isAdmin
          ? FloatingActionButton(
              onPressed: _addReunion,
              tooltip: 'Ajouter une Reunion',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  void _addReunion() {
    showDialog(
        context: context, builder: (context) => const AddReunionDialog());
  }
}
