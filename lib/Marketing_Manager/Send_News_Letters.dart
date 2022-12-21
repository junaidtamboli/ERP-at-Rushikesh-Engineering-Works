import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rushikesh_engg/widgets/Custom_Text_Field.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/theme.dart';

class SendNewsLetters extends StatefulWidget {
  const SendNewsLetters({Key? key}) : super(key: key);

  @override
  _SendNewsLettersState createState() => _SendNewsLettersState();
}

class _SendNewsLettersState extends State<SendNewsLetters> {
  List<String> attachments = [];
  bool isHTML = false;
  var selectedClient = [];
  final _subjectController = TextEditingController();

  final _bodyController = TextEditingController();
  List<String> recipients = [];
  final _formKey = GlobalKey<FormState>();
  makeList() {
    selectedClient.forEach((element) {
      recipients.add(element.toString());
    });
    send();
  }

  Future<void> send() async {
    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: recipients, //[_recipientController.text],
      attachmentPaths: attachments,
      isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Send News Letters',
                      style: heading2.copyWith(color: textBlack),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'assets/images/accent.png',
                      width: 99,
                      height: 4,
                    ),
                  ],
                ),
                SizedBox(
                  height: 48,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      clientDropDownList(),
                      SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: _subjectController,
                        hintText: 'Subject',
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Subject can\'t be empty';
                          }
                        },
                      ),
                      // myTextField("Subject", _subjectController, 1),
                      SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: _bodyController,
                        maxLineCount: 4,
                        hintText: 'Composed Email',
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Body can\'t be empty';
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            for (var i = 0; i < attachments.length; i++)
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      attachments[i],
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.remove_circle),
                                    onPressed: () => {_removeAttachment(i)},
                                  )
                                ],
                              ),
                            TextButton(
                              child: Text('Attach files from storage'),
                              onPressed: () => _openImagePicker(),
                            ),
                            TextButton(
                              child: Text(
                                  'Attach file in app documents directory'),
                              onPressed: () =>
                                  _attachFileFromAppDocumentsDirectoy(),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(14.0),
                              elevation: 0,
                              child: Container(
                                height: 56,
                                decoration: BoxDecoration(
                                  color: primaryBlue,
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      if (_formKey.currentState!.validate() &&
                                          recipients.isNotEmpty) {
                                        makeList();
                                      } else if (recipients.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: "Please select recipients");
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(14.0),
                                    child: Center(
                                      child: Text(
                                        'Send Email',
                                        style: heading5.copyWith(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget clientDropDownList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection(clientsdata).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text("Please wait...");
        } else {
          List<MultiSelectItem> clientList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            DocumentSnapshot snap = snapshot.data!.docs[i];
            clientList.add(
              MultiSelectItem(
                snap.get(clientEmail),
                snap.get(clientName),
              ),
            );
          }
          return Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: textWhiteGrey,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MultiSelectDialogField(
                searchable: true,
                onConfirm: (val) {
                  selectedClient = val;
                },
                dialogWidth: MediaQuery.of(context).size.width * 0.7,
                items: clientList,
                initialValue: selectedClient,
              ),
            ),
          );
        }
      },
    );
  }

  Widget myTextField(
      String hintText, TextEditingController controller, int maxLines) {
    return Container(
      decoration: BoxDecoration(
        color: textWhiteGrey,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          label: Text(
            hintText,
            style: regular12pt,
          ),
          hintStyle: heading6.copyWith(color: textGrey),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  void _openImagePicker() async {
    final picker = ImagePicker();
    PickedFile? pick = await picker.getImage(source: ImageSource.gallery);
    if (pick != null) {
      setState(() {
        attachments.add(pick.path);
      });
    }
  }

  void _removeAttachment(int index) {
    setState(() {
      attachments.removeAt(index);
    });
  }

  Future<void> _attachFileFromAppDocumentsDirectoy() async {
    try {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      final filePath = appDocumentDir.path + '/file.txt';
      final file = File(filePath);
      await file.writeAsString('Text file in app directory');

      setState(() {
        attachments.add(filePath);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create file in applicion directory'),
        ),
      );
    }
  }
}
