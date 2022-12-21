import 'dart:async';

abstract class AppMethods {
  Future<String> logginUser({required String email, required String password});

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
      required String password});

  Future<String> updateUserAccount(
      {required String userId,
      required String name,
      required String address,
      required String country,
      required String state,
      required String city,
      required String contactNo,
      required String email,
      required String employeeType,
      required String deptName,
      required String dob});

  Future<String> deleteUserAccount({
    required String userId,
  });

  Future<String> createNewProject({
    required String proj_name,
    required String proj_desc,
    required String proj_start_date,
    required String proj_end_date,
    required String proj_client,
    required String proj_manager,
  });

  Future<String> AddNewClient({
    required String client_name,
    required String client_address,
    required String client_country,
    required String client_state,
    required String client_city,
    required String client_contact,
    required String client_email,
    required String client_fax,
  });

  Future<String> createCandidateProfile({
    required String name,
    required String address,
    required String country,
    required String state,
    required String city,
    required String contactNo,
    required String email,
    required String dob,
  });

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
  });

  Future<String> deleteCandidateProfile({
    required String candidateId,
  });

  Future<String> markAttendance({
    required var list,
  });

  Future<String> updateTeamLeader({
    required String projectID,
    required String updatedTeamLeader,
  });

  Future<String> updateProjectStatus({
    required String projectID,
    required String status,
  });

  Future<String> updateTeamMembers({
    required String projectID,
    required var teamMembers,
  });

  Future<bool> logOutUser();
}
