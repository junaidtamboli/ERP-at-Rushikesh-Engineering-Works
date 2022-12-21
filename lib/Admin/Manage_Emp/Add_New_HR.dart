import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rushikesh_engg/widgets/Custom_Text_Field.dart';
import 'package:rushikesh_engg/Firebase/AppMethods.dart';
import 'package:rushikesh_engg/Firebase/FirebaseMethods.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/widgets/myValidation.dart';
import 'package:rushikesh_engg/theme.dart';
import 'package:rushikesh_engg/widgets/Dialog.dart';

class AddNewHR extends StatefulWidget {
  @override
  _AddNewHRState createState() => _AddNewHRState();
}

class _AddNewHRState extends State<AddNewHR> {
  AppMethods appMethod = FirebaseMethods();
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController contactNo = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController dob = TextEditingController();
  DateTime birthDate = DateTime.now();
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
                      'Add New HR Manager',
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
                        onTap: () => {
                          if (_formKey.currentState!.validate() &&
                              dob.text.isNotEmpty)
                            {createUser(context)}
                          else if (dob.text.isEmpty)
                            {Fluttertoast.showToast(msg: "Select Birth date")}
                        },
                        borderRadius: BorderRadius.circular(14.0),
                        child: Center(
                          child: Text(
                            'Save',
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

  createUser(BuildContext context) async {
    String res = await appMethod.createUserAccount(
        id: "",
        name: name.text,
        address: address.text,
        country: country.text,
        state: state.text,
        city: city.text,
        contactNo: contactNo.text,
        email: emailId.text,
        employeeType: "HR",
        deptName: "Management",
        dob: dob.text,
        password: defaultPassword);
    if (res == successful) {
      showSuccessDialog(context, "User Created", res);
    } else {
      showErrorDialog(context, "Failed to create user", res);
    }
  }
}
