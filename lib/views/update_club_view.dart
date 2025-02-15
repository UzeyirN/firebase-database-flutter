import 'package:firebase_operations/services/time_calculator.dart';
import 'package:firebase_operations/views/update_club_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/club.dart';

class UpdateClubView extends StatefulWidget {
  final Club club;

  const UpdateClubView({super.key, required this.club});

  @override
  State<UpdateClubView> createState() => _UpdateClubViewState();
}

class _UpdateClubViewState extends State<UpdateClubView> {
  TextEditingController clubNameController = TextEditingController();
  TextEditingController clubCoachController = TextEditingController();
  TextEditingController foundedDateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var selectedDate;

  @override
  void dispose() {
    clubNameController.dispose();
    clubCoachController.dispose();
    foundedDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    clubNameController.text = widget.club.clubName;
    clubCoachController.text = widget.club.clubCoach;
    foundedDateController.text = TimeCalculator.dateTimeToString(
      TimeCalculator.dateTimeFromTimestamp(widget.club.foundedDate),
    );
    return ChangeNotifierProvider<UpdateClubViewModel>(
      create: (_) => UpdateClubViewModel(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: Text('ADD BOOK'),
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: clubNameController,
                  decoration: InputDecoration(
                    hintText: 'Book name',
                    icon: Icon(Icons.book),
                  ),
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return " Book name can't be empty! ";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: clubCoachController,
                  decoration: InputDecoration(
                    hintText: 'Author name',
                    icon: Icon(Icons.edit),
                  ),
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return " Author name can't be empty! ";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  onTap: () async {
                    selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(-1000),
                      lastDate: DateTime.now(),
                    );
                    foundedDateController.text =
                        TimeCalculator.dateTimeToString(selectedDate!);
                  },
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  controller: foundedDateController,
                  decoration: InputDecoration(
                    hintText: 'Publish date',
                    icon: Icon(Icons.date_range),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return " Publish can't be empty! ";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await context.read<UpdateClubViewModel>().updateClub(
                            clubName: clubNameController.text,
                            clubCoach: clubCoachController.text,
                            foundedDate: selectedDate ??
                                TimeCalculator.dateTimeFromTimestamp(
                                    widget.club.foundedDate),
                            club: widget.club,
                          );

                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
