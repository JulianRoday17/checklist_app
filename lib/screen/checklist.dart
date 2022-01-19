import 'package:checklist_app/services/login_service.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class ChecklistPage extends StatefulWidget {
  final String token;
  final List data;
  // final topColor = Palette.flamingo.withOpacity(0.1);
  ChecklistPage(this.token, this.data);

  @override
  _ChecklistPageState createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  AuthRepository _repository = AuthServices();
  final TextEditingController inputController = TextEditingController();
  List finalData = [];

  @override
  void initState() {
    super.initState();
    finalData = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Text('Input new item'),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Container(
                        child: TextField(
                          controller: inputController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'New Item',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  child: Container(
                    height: 50,
                    width: 100,
                    child: Center(child: Text('Tambah item')),
                  ),
                  onPressed: () async {
                    try {
                      await _repository.addData(
                          inputController.text, widget.token);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Item Berhasil ditambahkan',
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      var response = await _repository.getAllData(widget.token);
                      var parsedResponse2 = json.decode(response);
                      Future.delayed(const Duration(milliseconds: 1000), () {
                        setState(() {
                          finalData = parsedResponse2['data'];
                        });
                      });
                    } catch (e) {
                      setState(() {});

                      print('gagal');
                    }
                  }),
              Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: finalData.length,
                    itemBuilder: (context, idx) {
                      return CheckboxListTile(
                        title: Text(finalData[idx]['name']),
                        value: finalData[idx]['checklistCompletionStatus'],
                        onChanged: (newValue) {
                          setState(() {
                            finalData[idx]['checklistCompletionStatus'] =
                                newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
