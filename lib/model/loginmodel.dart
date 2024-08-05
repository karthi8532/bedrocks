class LoginModel {
  bool? status;
  Message? message;
  String? token;

  LoginModel({this.status, this.message, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (message != null) {
      data['message'] = message!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class Message {
  UserImg? userImg;
  int? nsId;
  String? sId;
  String? employeeId;
  String? title;
  String? firstName;
  String? middleName;
  String? lastName;
  String? shortName;
  String? gender;
  String? dateOfBirth;
  String? department;
  String? designation;
  String? subsidiary;
  String? subdepartment;
  String? supervisor;
  String? linemanager;
  String? hod;
  String? workregioncountry;
  bool? inactive;
  String? employeejobstatus;
  String? joblocation;
  String? grade;
  String? employeecategory;
  String? maritalStatus;
  String? dateOfJoining;
  String? nationality;
  String? phone;
  String? emergencyContactPersonName;
  String? emergencyContactPersonPhoneNumber;
  String? passportNumber;
  String? passportNumberExpiryDate;
  String? nationalId;
  String? nationalIdExpiryDate;
  String? mobileusername;
  String? mobilepassword;
  bool? mobileaccess;
  String? source;
  int? syncStatus;
  List<Contacts>? contacts;
  List<Dependents>? dependents;
  List<Documents>? documents;
  List<WorkExperience>? workExperience;
  List<Skills>? skills;
  List<Education>? education;
  List<Salary>? salary;
  List<WorkingHours>? workingHours;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Message(
      {this.userImg,
      this.nsId,
      this.sId,
      this.employeeId,
      this.title,
      this.firstName,
      this.middleName,
      this.lastName,
      this.shortName,
      this.gender,
      this.dateOfBirth,
      this.department,
      this.designation,
      this.subsidiary,
      this.subdepartment,
      this.supervisor,
      this.linemanager,
      this.hod,
      this.workregioncountry,
      this.inactive,
      this.employeejobstatus,
      this.joblocation,
      this.grade,
      this.employeecategory,
      this.maritalStatus,
      this.dateOfJoining,
      this.nationality,
      this.phone,
      this.emergencyContactPersonName,
      this.emergencyContactPersonPhoneNumber,
      this.passportNumber,
      this.passportNumberExpiryDate,
      this.nationalId,
      this.nationalIdExpiryDate,
      this.mobileusername,
      this.mobilepassword,
      this.mobileaccess,
      this.source,
      this.syncStatus,
      this.contacts,
      this.dependents,
      this.documents,
      this.workExperience,
      this.skills,
      this.education,
      this.salary,
      this.workingHours,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Message.fromJson(Map<String, dynamic> json) {
    userImg =
        json['userImg'] != null ? UserImg.fromJson(json['userImg']) : null;
    sId = json['_id'];
    nsId = json['nsId'];
    employeeId = json['employeeCode'];
    title = json['title'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    shortName = json['shortName'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    department = json['department'];
    designation = json['designation'];
    subsidiary = json['subsidiary'];
    subdepartment = json['subdepartment'];
    supervisor = json['supervisor'];
    linemanager = json['linemanager'];
    hod = json['hod'];
    workregioncountry = json['workregioncountry'];
    inactive = json['inactive'];
    employeejobstatus = json['employeejobstatus'];
    joblocation = json['joblocation'];
    grade = json['grade'];
    employeecategory = json['employeecategory'];
    maritalStatus = json['maritalStatus'];
    dateOfJoining = json['dateOfJoining'];
    nationality = json['nationality'];
    phone = json['phone'];
    emergencyContactPersonName = json['emergencyContactPersonName'];
    emergencyContactPersonPhoneNumber =
        json['emergencyContactPersonPhoneNumber'];
    passportNumber = json['passportNumber'];
    passportNumberExpiryDate = json['passportNumberExpiryDate'];
    nationalId = json['nationalId'];
    nationalIdExpiryDate = json['nationalIdExpiryDate'];
    mobileusername = json['mobileusername'];
    mobilepassword = json['mobilepassword'];
    mobileaccess = json['mobileaccess'];
    source = json['source'];
    syncStatus = json['syncStatus'];
    if (json['contacts'] != null) {
      contacts = <Contacts>[];
      json['contacts'].forEach((v) {
        contacts!.add(Contacts.fromJson(v));
      });
    }
    if (json['dependents'] != null) {
      dependents = <Dependents>[];
      json['dependents'].forEach((v) {
        dependents!.add(Dependents.fromJson(v));
      });
    }
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(Documents.fromJson(v));
      });
    }
    if (json['workExperience'] != null) {
      workExperience = <WorkExperience>[];
      json['workExperience'].forEach((v) {
        workExperience!.add(WorkExperience.fromJson(v));
      });
    }
    if (json['skills'] != null) {
      skills = <Skills>[];
      json['skills'].forEach((v) {
        skills!.add(Skills.fromJson(v));
      });
    }
    if (json['education'] != null) {
      education = <Education>[];
      json['education'].forEach((v) {
        education!.add(Education.fromJson(v));
      });
    }
    if (json['salary'] != null) {
      salary = <Salary>[];
      json['salary'].forEach((v) {
        salary!.add(Salary.fromJson(v));
      });
    }
    if (json['workingHours'] != null) {
      workingHours = <WorkingHours>[];
      json['workingHours'].forEach((v) {
        workingHours!.add(WorkingHours.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userImg != null) {
      data['userImg'] = userImg!.toJson();
    }
    data['_id'] = sId;
    data['nsId'] = nsId;
    data['employeeCode'] = employeeId;
    data['title'] = title;
    data['firstName'] = firstName;
    data['middleName'] = middleName;
    data['lastName'] = lastName;
    data['shortName'] = shortName;
    data['gender'] = gender;
    data['dateOfBirth'] = dateOfBirth;
    data['department'] = department;
    data['designation'] = designation;
    data['subsidiary'] = subsidiary;
    data['subdepartment'] = subdepartment;
    data['supervisor'] = supervisor;
    data['linemanager'] = linemanager;
    data['hod'] = hod;
    data['workregioncountry'] = workregioncountry;
    data['inactive'] = inactive;
    data['employeejobstatus'] = employeejobstatus;
    data['joblocation'] = joblocation;
    data['grade'] = grade;
    data['employeecategory'] = employeecategory;
    data['maritalStatus'] = maritalStatus;
    data['dateOfJoining'] = dateOfJoining;
    data['nationality'] = nationality;
    data['phone'] = phone;
    data['emergencyContactPersonName'] = emergencyContactPersonName;
    data['emergencyContactPersonPhoneNumber'] =
        emergencyContactPersonPhoneNumber;
    data['passportNumber'] = passportNumber;
    data['passportNumberExpiryDate'] = passportNumberExpiryDate;
    data['nationalId'] = nationalId;
    data['nationalIdExpiryDate'] = nationalIdExpiryDate;
    data['mobileusername'] = mobileusername;
    data['mobilepassword'] = mobilepassword;
    data['mobileaccess'] = mobileaccess;
    data['source'] = source;
    data['syncStatus'] = syncStatus;
    if (contacts != null) {
      data['contacts'] = contacts!.map((v) => v.toJson()).toList();
    }
    if (dependents != null) {
      data['dependents'] = dependents!.map((v) => v.toJson()).toList();
    }
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    if (workExperience != null) {
      data['workExperience'] = workExperience!.map((v) => v.toJson()).toList();
    }
    if (skills != null) {
      data['skills'] = skills!.map((v) => v.toJson()).toList();
    }
    if (education != null) {
      data['education'] = education!.map((v) => v.toJson()).toList();
    }
    if (salary != null) {
      data['salary'] = salary!.map((v) => v.toJson()).toList();
    }
    if (workingHours != null) {
      data['workingHours'] = workingHours!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class UserImg {
  String? imgName;
  String? imgUrl;

  UserImg({this.imgName, this.imgUrl});

  UserImg.fromJson(Map<String, dynamic> json) {
    imgName = json['imgName'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imgName'] = imgName;
    data['imgUrl'] = imgUrl;
    return data;
  }
}

class Contacts {
  String? address;
  String? address1;
  String? address2;
  String? city;
  String? statedisplayname;
  String? country;
  String? zipCode;
  String? phone;
  String? internalId;
  String? firstName;
  bool? defaultBilling;
  String? sId;

  Contacts(
      {this.address,
      this.address1,
      this.address2,
      this.city,
      this.statedisplayname,
      this.country,
      this.zipCode,
      this.phone,
      this.internalId,
      this.firstName,
      this.defaultBilling,
      this.sId});

  Contacts.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    statedisplayname = json['statedisplayname'];
    country = json['country'];
    zipCode = json['zip_Code'];
    phone = json['phone'];
    internalId = json['internal_id'];
    firstName = json['first_name'];
    defaultBilling = json['default_billing'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['address1'] = address1;
    data['address2'] = address2;
    data['city'] = city;
    data['statedisplayname'] = statedisplayname;
    data['country'] = country;
    data['zip_Code'] = zipCode;
    data['phone'] = phone;
    data['internal_id'] = internalId;
    data['first_name'] = firstName;
    data['default_billing'] = defaultBilling;
    data['_id'] = sId;
    return data;
  }
}

class Dependents {
  String? name;
  String? dateOfBirth;
  String? relationship;
  String? passportNumber;
  String? passportNumberExpiryDate;
  String? nationalId;
  String? nationalIdExpiryDate;
  String? insuranceEligibility;
  String? airTicketEligibility;
  String? internalId;
  String? sId;

  Dependents(
      {this.name,
      this.dateOfBirth,
      this.relationship,
      this.passportNumber,
      this.passportNumberExpiryDate,
      this.nationalId,
      this.nationalIdExpiryDate,
      this.insuranceEligibility,
      this.airTicketEligibility,
      this.internalId,
      this.sId});

  Dependents.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dateOfBirth = json['dateOfBirth'];
    relationship = json['relationship'];
    passportNumber = json['passportNumber'];
    passportNumberExpiryDate = json['passportNumberExpiryDate'];
    nationalId = json['nationalId'];
    nationalIdExpiryDate = json['nationalIdExpiryDate'];
    insuranceEligibility = json['insuranceEligibility'];
    airTicketEligibility = json['airTicketEligibility'];
    internalId = json['internal_id'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['dateOfBirth'] = dateOfBirth;
    data['relationship'] = relationship;
    data['passportNumber'] = passportNumber;
    data['passportNumberExpiryDate'] = passportNumberExpiryDate;
    data['nationalId'] = nationalId;
    data['nationalIdExpiryDate'] = nationalIdExpiryDate;
    data['insuranceEligibility'] = insuranceEligibility;
    data['airTicketEligibility'] = airTicketEligibility;
    data['internal_id'] = internalId;
    data['_id'] = sId;
    return data;
  }
}

class Documents {
  String? documentName;
  String? documentNumber;
  String? issuedBy;
  String? issuedDate;
  String? expiryDate;
  String? attachment;
  String? remarks;
  String? internalId;
  String? sId;

  Documents(
      {this.documentName,
      this.documentNumber,
      this.issuedBy,
      this.issuedDate,
      this.expiryDate,
      this.attachment,
      this.remarks,
      this.internalId,
      this.sId});

  Documents.fromJson(Map<String, dynamic> json) {
    documentName = json['documentName'];
    documentNumber = json['documentNumber'];
    issuedBy = json['issuedBy'];
    issuedDate = json['issuedDate'];
    expiryDate = json['expiryDate'];
    attachment = json['attachment'];
    remarks = json['remarks'];
    internalId = json['internal_id'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['documentName'] = documentName;
    data['documentNumber'] = documentNumber;
    data['issuedBy'] = issuedBy;
    data['issuedDate'] = issuedDate;
    data['expiryDate'] = expiryDate;
    data['attachment'] = attachment;
    data['remarks'] = remarks;
    data['internal_id'] = internalId;
    data['_id'] = sId;
    return data;
  }
}

class WorkExperience {
  String? company;
  String? jobTitle;
  String? fromDate;
  String? toDate;
  String? comments;
  String? internalId;
  String? sId;

  WorkExperience(
      {this.company,
      this.jobTitle,
      this.fromDate,
      this.toDate,
      this.comments,
      this.internalId,
      this.sId});

  WorkExperience.fromJson(Map<String, dynamic> json) {
    company = json['company'];
    jobTitle = json['jobTitle'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    comments = json['comments'];
    internalId = json['internal_id'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company'] = company;
    data['jobTitle'] = jobTitle;
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    data['comments'] = comments;
    data['internal_id'] = internalId;
    data['_id'] = sId;
    return data;
  }
}

class Skills {
  String? internalId;
  String? skillName;
  String? skillCode;
  String? certificate;
  String? yearOfExperience;
  String? sId;

  Skills(
      {this.internalId,
      this.skillName,
      this.skillCode,
      this.certificate,
      this.yearOfExperience,
      this.sId});

  Skills.fromJson(Map<String, dynamic> json) {
    internalId = json['internal_id'];
    skillName = json['skillName'];
    skillCode = json['skill_code'];
    certificate = json['certificate'];
    yearOfExperience = json['yearOfExperience'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['internal_id'] = internalId;
    data['skillName'] = skillName;
    data['skill_code'] = skillCode;
    data['certificate'] = certificate;
    data['yearOfExperience'] = yearOfExperience;
    data['_id'] = sId;
    return data;
  }
}

class Education {
  String? internalId;
  String? education;
  String? collegeUniversity;
  String? passingYear;
  String? sId;

  Education(
      {this.internalId,
      this.education,
      this.collegeUniversity,
      this.passingYear,
      this.sId});

  Education.fromJson(Map<String, dynamic> json) {
    internalId = json['internal_id'];
    education = json['education'];
    collegeUniversity = json['college_university'];
    passingYear = json['passing_year'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['internal_id'] = internalId;
    data['education'] = education;
    data['college_university'] = collegeUniversity;
    data['passing_year'] = passingYear;
    data['_id'] = sId;
    return data;
  }
}

class Salary {
  String? componentName;
  String? type;
  int? monthly;
  int? annually;
  String? currency;
  String? sId;

  Salary(
      {this.componentName,
      this.type,
      this.monthly,
      this.annually,
      this.currency,
      this.sId});

  Salary.fromJson(Map<String, dynamic> json) {
    componentName = json['componentName'];
    type = json['type'];
    monthly = json['monthly'];
    annually = json['annually'];
    currency = json['currency'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['componentName'] = componentName;
    data['type'] = type;
    data['monthly'] = monthly;
    data['annually'] = annually;
    data['currency'] = currency;
    data['_id'] = sId;
    return data;
  }
}

class WorkingHours {
  String? typeid;
  String? effectivefrom;
  String? effectiveto;
  String? totalworkinghours;
  String? sId;

  WorkingHours(
      {this.typeid,
      this.effectivefrom,
      this.effectiveto,
      this.totalworkinghours,
      this.sId});

  WorkingHours.fromJson(Map<String, dynamic> json) {
    typeid = json['typeid'];
    effectivefrom = json['effectivefrom'];
    effectiveto = json['effectiveto'];
    totalworkinghours = json['totalworkinghours'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['typeid'] = typeid;
    data['effectivefrom'] = effectivefrom;
    data['effectiveto'] = effectiveto;
    data['totalworkinghours'] = totalworkinghours;
    data['_id'] = sId;
    return data;
  }
}
