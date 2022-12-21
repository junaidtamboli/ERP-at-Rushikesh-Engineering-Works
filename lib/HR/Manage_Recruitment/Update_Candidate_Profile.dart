import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rushikesh_engg/Firebase/appData.dart';
import 'package:rushikesh_engg/widgets/Custom_Text_Field.dart';
import 'package:rushikesh_engg/Firebase/AppMethods.dart';
import 'package:rushikesh_engg/Firebase/FirebaseMethods.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/widgets/myValidation.dart';
import 'package:rushikesh_engg/theme.dart';
import 'package:rushikesh_engg/widgets/Dialog.dart';

class UpdateCandidateProfile extends StatefulWidget {
  final DocumentSnapshot post;
  UpdateCandidateProfile({required this.post});
  @override
  _UpdateCandidateProfileState createState() => _UpdateCandidateProfileState();
}

class _UpdateCandidateProfileState extends State<UpdateCandidateProfile> {
  AppMethods appMethod = FirebaseMethods();

  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController contactNo = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController marks = TextEditingController();
  String? cand_status;
  DateTime birthDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    id.text = widget.post[candidateId];
    name.text = widget.post[candidateName];
    address.text = widget.post[candidateAddr];
    country.text = widget.post[candidateCountry];
    state.text = widget.post[candidateState];
    city.text = widget.post[candidateCity];
    contactNo.text = widget.post[candidateContact];
    emailId.text = widget.post[candidateEmail];
    dob.text = widget.post[candidateDOB];
    cand_status = widget.post[candidateStatus];
    marks.text = widget.post[candidateMarks];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Update Candidate Profile',
                      style: heading2.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'assets/images/accent.png',
                      width: 99,
                      height: 4,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 48,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomFormField(
                        controller: id,
                        hintText: 'ID',
                        isReadOnly: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: name,
                        hintText: 'Full Name',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z]+|\s"),
                          )
                        ],
                        validator: (val) {
                          if (val!.isValidName) {
                            return null;
                          } else {
                            return 'Enter valid name';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: address,
                        hintText: 'Address',
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Enter valid Address';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: country,
                        hintText: 'Country',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z]+|\s"),
                          )
                        ],
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Enter valid country name';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: state,
                        hintText: 'State',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z]+|\s"),
                          )
                        ],
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Enter valid state name';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: city,
                        hintText: 'City',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z]+|\s"),
                          ),
                        ],
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Enter valid city name';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: contactNo,
                        hintText: 'Contact No.',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r"[0-9]"),
                          )
                        ],
                        validator: (val) {
                          if (val!.isValidPhone) {
                            return null;
                          } else {
                            return 'Enter valid phone';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: emailId,
                        hintText: 'Email',
                        validator: (val) {
                          if (val!.isValidEmail) {
                            return null;
                          } else {
                            return 'Enter valid email';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          onTap: () => _selectBirthDate(context),
                          readOnly: true,
                          controller: dob,
                          decoration: InputDecoration(
                            label: Text(
                              "Birth Date",
                              style: regular12pt,
                            ),
                            hintStyle: heading6.copyWith(color: textGrey),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            value: cand_status,
                            items: candidateStatusList.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                cand_status = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: marks,
                        hintText: 'Marks',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r"[0-9]"),
                          )
                        ],
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Enter valid marks';
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
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
                          if (_formKey.currentState!.validate()) {
                            UpdateCandidateProfile(context);
                          }
                        },
                        borderRadius: BorderRadius.circular(14.0),
                        child: Center(
                          child: Text(
                            'Update',
                            style: heading5.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(1970),
        firstDate: DateTime(1970),
        lastDate: DateTime(2010));
    if (pickedDate != null) {
      setState(() {
        birthDate = pickedDate;
        dob.text = formatter.format(pickedDate).toString();
      });
    }
  }

  UpdateCandidateProfile(BuildContext context) async {
    String res = await appMethod.updateCandidateProfile(
      candidateId: widget.post[candidateId],
      name: name.text,
      address: address.text,
      country: country.text,
      state: state.text,
      city: city.text,
      contactNo: contactNo.text,
      email: emailId.text,
      dob: dob.text,
      status: cand_status!,
      marks: marks.text,
    );

    if (res == successful) {
      showSuccessDialog(context, "Update Successful", res);
    } else {
      showErrorDialog(context, "Failed to update information", res);
    }
  }
}

Widget myTextField(
    String hintText, TextEditingController controller, bool isReadOnly) {
  return Container(
    decoration: BoxDecoration(
      color: textWhiteGrey,
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: TextFormField(
      controller: controller,
      readOnly: isReadOnly,
      decoration: InputDecoration(
        label: Text(
          hintText,
          style: regular12pt,
        ),
        hintStyle: heading6.copyWith(color: textGrey),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: (text) {
        controller = text as TextEditingController;
      },
    ),
  );
}
