import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rushikesh_engg/Firebase/AppMethods.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/Firebase/app_tools.dart';

class FirebaseMethods implements AppMethods {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  //creating a new user
  @override
  Future<String> createUserAccount(
      {required String id,
      required String name,
      required String address,
      required String country,
      required String state,
      required String city,
      required String contactNo,
      required String email,
      required String employeeType,
      required String deptName,
      required String dob,
      required String password}) async {
    User user;
    try {
      user = (await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user!;

      await firestore.collection(usersData).doc(user.uid).set({
        empId: user.uid,
        empName: name,
        empAddr: address,
        empCountry: country,
        empState: state,
        empCity: city,
        empContact: contactNo,
        empEmail: email,
        empType: employeeType,
        empDept: deptName,
        empDOB: dob,
      }).then((_) async {
        if (id != "") {
          try {
            await firestore.collection(candidatesData).doc(id).delete();
          } on Exception catch (e) {
            return errorMSG(e.toString());
          }
        }
      });
      writeDataLocally(key: empId, value: user.uid);
      writeDataLocally(key: empType, value: empType);
    } on Exception catch (e) {
      return errorMSG(e.toString());
    }
    return successfulMSG();
  }

  //Updating Employee Details
  @override
  Future<String> updateUserAccount({
    required String userId,
    required String name,
    required String address,
    required String country,
    required String state,
    required String city,
    required String contactNo,
    required String email,
    required String employeeType,
    required String deptName,
    required String dob,
  }) async {
    try {
      await firestore.collection(usersData).doc(userId).set({
        empName: name,
        empAddr: address,
        empCountry: country,
        empState: state,
        empCity: city,
        empContact: contactNo,
        empEmail: email,
        empType: employeeType,
        empDept: deptName,
        empDOB: dob,
      }, SetOptions(merge: true));
    } on Exception catch (e) {
      return errorMSG(e.toString());
    }
    return successfulMSG();
  }

  //Deleting Employee Details
  @override
  Future<String> deleteUserAccount({
    required String userId,
  }) async {
    try {
      await firestore.collection(usersData).doc(userId).delete();
      //then((_) {
      // delete account on authentication after user data on database is deleted

      // });
    } on Exception catch (e) {
      return errorMSG(e.toString());
    }
    return successfulMSG();
  }

  //user login
  @override
  Future<String> logginUser(
      {required String email, required String password}) async {
    User user;
    try {
      user = (await auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      DocumentSnapshot userInfo = await getUserInfo(user.uid);
      await writeDataLocally(key: empType, value: userInfo[empType]);
      await writeDataLocally(key: empId, value: user.uid);
    } on Exception catch (e) {
      return errorMSG(e.toString());
    }
    return successfulMSG();
  }

  //user logout
  @override
  Future<bool> logOutUser() async {
    await auth.signOut();
    await clearDataLocally();

    return complete();
  }

  @override
  Future<String> createNewProject(
      {required String proj_name,
      required String proj_desc,
      required String proj_start_date,
      required String proj_end_date,
      required String proj_client,
      required String proj_manager}) async {
    try {
      String projID = (DateTime.now().millisecondsSinceEpoch).toString();
      await firestore.collection(projectsdata).doc(projID).set(
        {
          projId: projID,
          projName: proj_name,
          projDesc: proj_desc,
          projStartDate: proj_start_date,
          projEndDate: proj_end_date,
          projClient: proj_client,
          projManager: proj_manager,
          projTeamLeader: "NA",
          projStatus: "Created",
          projMembers: [],
        },
      );
    } on Exception catch (e) {
      return errorMSG(e.toString());
    }
    return successfulMSG();
  }

  @override
  Future<String> AddNewClient(
      {required String client_name,
      required String client_address,
      required String client_country,
      required String client_state,
      required String client_city,
      required String client_contact,
      required String client_email,
      required String client_fax}) async {
    try {
      String clientID = (DateTime.now().millisecondsSinceEpoch).toString();
      await firestore.collection(clientsdata).doc(clientID).set(
        {
          clientId: clientID,
          clientName: client_name,
          clientAddress: client_address,
          clientCountry: client_country,
          clientState: client_state,
          clientCity: client_city,
          clientContact: client_city,
          clientEmail: client_email,
          clientFax: client_fax,
          clientMarketingManager: await getStringDataLocally(key: empId),
        },
      );
    } on Exception catch (e) {
      return errorMSG(e.toString());
    }
    return successfulMSG();
  }

  @override
  Future<String> createCandidateProfile(
      {required String name,
      required String address,
      required String country,
      required String state,
      required String city,
      required String contactNo,
      required String email,
      required String dob}) async {
    try {
      String candidateID = (DateTime.now().millisecondsSinceEpoch).toString();
      await firestore.collection(candidatesData).doc(candidateID).set(
        {
          candidateId: candidateID,
          candidateName: name,
          candidateAddr: address,
          candidateCountry: country,
          candidateState: state,
          candidateCity: city,
          candidateContact: contactNo,
          candidateEmail: email,
          candidateDOB: dob,
          candidateStatus: "Profile Created",
          candidateMarks: "0",
        },
      );
    } on Exception catch (e) {
      return errorMSG(e.toString());
    }

    return successfulMSG();
  }

  @override
  Future<String> updateCandidateProfile({
    required String candidateId,
    required String name,
    required String address,
    required String country,
    required String state,
    required String city,
    required String contactNo,
    required String email,
    required String status,
    required String marks,
    required String dob,
  }) async {
    try {
      await firestore.collection(candidatesData).doc(candidateId).set({
        candidateName: name,
        candidateAddr: address,
        candidateCountry: country,
        candidateState: state,
        candidateCity: city,
        candidateContact: contactNo,
        candidateEmail: email,
        candidateStatus: status,
        candidateMarks: marks,
        candidateDOB: dob,
      }, SetOptions(merge: true));
    } on Exception catch (e) {
      return errorMSG(e.toString());
    }
    return successfulMSG();
  }

  @override
  Future<String> deleteCandidateProfile({required String candidateId}) async {
    try {
      await firestore.collection(candidatesData).doc(candidateId).delete();
    } on Exception catch (e) {
      return errorMSG(e.toString());
    }
    return successfulMSG();
  }

  @override
  Future<String> markAttendance({required list}) async {
    try {
      final DateTime now = DateTime.now();
      // final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final String formatted = formatter.format(now);
      await firestore.collection(attendanceData).doc(formatted).set({
        presentEmp: list,
        attendanceDate: formatted,
      }, SetOptions(merge: true));
    } on Exception catch (e) {
      return errorMSG(e.toString());
    }
    return successfulMSG();
  }

  @override
  Future<String> updateTeamLeader({
    required String projectID,
    required String updatedTeamLeader,
  }) async {
    try {
      await firestore.collection(projectsdata).doc(projectID).set({
        projTeamLeader: updatedTeamLeader,
      }, SetOptions(merge: true));
    } on Exception catch (e) {
      return errorMSG(e.toString());
    }
    return successfulMSG();
  }

  @override
  Future<DocumentSnapshot> getUserInfo(String userid) async {
    return await firestore.collection(usersData).doc(userid).get();
  }

  @override
  Future<String> updateTeamMembers(
      {required String projectID, required teamMembers}) async {
    try {
      await firestore.collection(projectsdata).doc(projectID).set({
        projMembers: teamMembers,
      }, SetOptions(merge: true));
    } on Exception catch (e) {
      return errorMSG(e.toString());
    }
    return successfulMSG();
  }

  @override
  Future<String> updateProjectStatus(
      {required String projectID, required String status}) async {
    try {
      await firestore.collection(projectsdata).doc(projectID).set({
        projStatus: status,
      }, SetOptions(merge: true));
    } on Exception catch (e) {
      return errorMSG(e.toString());
    }
    return successfulMSG();
  }
}

Future<bool> complete() async {
  return true;
}

Future<bool> notComplete() async {
  return false;
}

Future<String> successfulMSG() async {
  return successful;
}

Future<String> errorMSG(String e) async {
  return e;
}
