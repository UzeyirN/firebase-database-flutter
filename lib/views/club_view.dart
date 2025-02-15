import 'package:firebase_operations/models/club.dart';
import 'package:firebase_operations/views/add_club_view.dart';
import 'package:firebase_operations/views/club_view_model.dart';
import 'package:firebase_operations/views/update_club_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class ClubView extends StatefulWidget {
  const ClubView({super.key});

  @override
  State<ClubView> createState() => _ClubViewState();
}

class _ClubViewState extends State<ClubView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ClubViewModel>(
      create: (_) => ClubViewModel(),
      builder: (context, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text(
            'CLUBS',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        body: StreamBuilder(
          stream:
              Provider.of<ClubViewModel>(context, listen: false).getClubsList(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Clubs are not available'),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            List<Club> clubList = snapshot.data!;

            return BuildListData(clubList: clubList);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddClubView(),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class BuildListData extends StatefulWidget {
  const BuildListData({
    super.key,
    required this.clubList,
  });

  final List<Club> clubList;

  @override
  State<BuildListData> createState() => _BuildListDataState();
}

class _BuildListDataState extends State<BuildListData> {
  bool isFiltered = false;
  List<Club> filteredList = [];

  @override
  Widget build(BuildContext context) {
    var fullList = widget.clubList;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (query) {
              if (query.isNotEmpty) {
                isFiltered = true;
                setState(() {
                  filteredList = fullList
                      .where((club) => club.clubName.toLowerCase().contains(
                            query.toLowerCase(),
                          ))
                      .toList();
                });
              } else {
                WidgetsBinding.instance.focusManager.primaryFocus!.unfocus();
                setState(() {
                  isFiltered = false;
                });
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Search clubs',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: isFiltered ? filteredList.length : fullList.length,
            itemBuilder: (context, index) {
              var list = isFiltered ? filteredList : fullList;
              return Slidable(
                key: ValueKey(list[index].clubID),
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  dismissible: DismissiblePane(onDismissed: () {
                    context
                        .read<ClubViewModel>()
                        .deleteClub(widget.clubList[index]);
                  }),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        context.read<ClubViewModel>().deleteClub(list[index]);
                      },
                      backgroundColor: Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                    SlidableAction(
                      onPressed: (_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateClubView(
                              club: list[index],
                            ),
                          ),
                        );
                      },
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                  ],
                ),
                startActionPane: const ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: null,
                      backgroundColor: Color(0xFF7BC043),
                      foregroundColor: Colors.white,
                      icon: Icons.archive,
                      label: 'Archive',
                    ),
                    SlidableAction(
                      onPressed: null,
                      backgroundColor: Color(0xFF0392CF),
                      foregroundColor: Colors.white,
                      icon: Icons.save,
                      label: 'Save',
                    ),
                  ],
                ),
                child: Card(
                  child: ListTile(
                    title: Text(list[index].clubName),
                    subtitle: Text(list[index].clubCoach),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
