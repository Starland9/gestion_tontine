import 'package:flutter/material.dart';
import 'package:gestion_tontine/models/profile/profile.dart';
import 'package:gestion_tontine/screens/profile/profile_add_dialog.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfilesPage extends StatefulWidget {
  const ProfilesPage({super.key});

  @override
  State<ProfilesPage> createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage> {
  List<Profile> selectedMeetings = [];
  List<Profile> meetingList = [];
  List<Profile> filteredMeetingList = [];

  @override
  void initState() {
    meetingList = Hive.box<Profile>('profiles').values.toList();
    filteredMeetingList = meetingList;
    super.initState();
  }

  void _searchMeeting(String query) {
    setState(() {
      filteredMeetingList = meetingList
          .where((meeting) =>
              meeting.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _toggleMeetingSelection(Profile meeting) {
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
    final box = Hive.box<Profile>('profiles');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des profiles'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _searchMeeting,
              decoration: const InputDecoration(
                labelText: 'Rechercher un profile',
              ),
            ),
          ),
          ValueListenableBuilder<Box<Profile>>(
            valueListenable: box.listenable(),
            builder: (context, box, _) {
              return Expanded(
                child: ListView.builder(
                  itemCount: filteredMeetingList.length,
                  itemBuilder: (context, index) {
                    final account = filteredMeetingList[index];
                    // final isSelected = selectedMeetings.contains(account);

                    return ListTile(
                      leading: const Icon(
                        Icons.attach_money,
                        color: Colors.blue,
                      ),
                      title: Text(account.name),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          box.deleteAt(index);
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const ProfileAddDialog(),
          );
        },
      ),
    );
  }
}
