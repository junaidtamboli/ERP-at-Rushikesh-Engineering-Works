import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rushikesh_engg/widgets/Custom_Text_Field.dart';
import 'package:rushikesh_engg/Firebase/AppMethods.dart';
import 'package:rushikesh_engg/Firebase/FirebaseMethods.dart';
import 'package:rushikesh_engg/Firebase/appData.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/widgets/myValidation.dart';
import 'package:rushikesh_engg/theme.dart';
import 'package:rushikesh_engg/widgets/Dialog.dart';

class UpdateEmpDetails extends StatefulWidget {
  final DocumentSnapshot post;
  UpdateEmpDetails({required this.post});
  @override
  _UpdateEmpDetailsState createState() => _UpdateEmpDetailsState();
}

class _UpdateEmpDetailsState extends State<UpdateEmpDetails> {
  AppMethods appMethod = FirebaseMethods();
  final _formKey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController contactNo = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController dob = TextEditingController();
  DateTime birthDate = DateTime.now();
  String? employeeType;
  String? dept;
  @override
  void initState() {
    super.initState();
    id.text = widget.post[empId];
    name.text = widget.post[empName];
    address.text = widget.post[empAddr];
    country.text = widget.post[empCountry];
    state.text = widget.post[empState];
    city.text = widget.post[empCity];
    contactNo.text = widget.post[empContact];
    emailId.text = widget.post[empEmail];
    employeeType = widget.post[empType];
    dept = widget.post[empDept];
    dob.text = widget.post[empDOB];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
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
                      'Update Employee Details',
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
                    children: [
                      CustomFormField(
                        controller: id,
                        isReadOnly: true,
                        hintText: 'ID',
                      ),
                      SizedBox(
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
                      SizedBox(
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
                      SizedBox(
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
                      SizedBox(
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
                      SizedBox(
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
                      SizedBox(
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
                      SizedBox(
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
                      SizedBox(
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
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
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
                            value: employeeType,
                            items: empTypeList.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                employeeType = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
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
                            value: dept,
                            items: deptList.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dept = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
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
                              employeeType != "Select Employee Type" &&
                              dept != "Select Department") {
                            UpdateUserDetails(context);
                          } else if (employeeType == "Select Login Type") {
                            Fluttertoast.showToast(
                                msg: "Select valid employee type");
                          } else if (dept == "Select Department") {
                            Fluttertoast.showToast(
                                msg: "Select valid department");
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
                SizedBox(
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

  UpdateUserDetails(BuildContext context) async {
    String res = await appMethod.updateUserAccount(
      userId: widget.post[empId],
      name: name.text,
      address: address.text,
      country: country.text,
      state: state.text,
      city: city.text,
      contactNo: contactNo.text,
      email: emailId.text,
      employeeType: employeeType!,
      deptName: dept!,
      dob: dob.text,
    );

    if (res == successful) {
      showSuccessDialog(context, "Update Successful", res);
    } else {
      showErrorDialog(context, "Failed to update information", res);
    }
  }
}
