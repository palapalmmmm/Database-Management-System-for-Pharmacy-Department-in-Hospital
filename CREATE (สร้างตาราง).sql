CREATE TABLE DrugWarehouse(
  DWR_ID NCHAR(6) PRIMARY KEY NOT NULL,
  DWR_CAPACITY SMALLINT NOT NULL,
  DWR_DRUG NVARCHAR(40) NOT NULL,
  DWR_UPDATE_DATE DATETIME NOT NULL
);

CREATE TABLE PatientRegistration(
  PAR_IDCARD NCHAR(13) PRIMARY KEY NOT NULL,
  PAR_NAME NVARCHAR(20) NOT NULL,
  PAR_SURNAME NVARCHAR(20) NOT NULL,
  PAR_GENDER NVARCHAR(6) NOT NULL,
  PAR_BIRTHDATE DATE NOT NULL,
  PAR_ADDRESS NVARCHAR(100) NOT NULL,
  PAR_PER_PHONE NCHAR(10) NOT NULL,
  PAR_REL_PHONE NCHAR(10),
  PAR_WEIGHT DECIMAL(5,2) NOT NULL,
  PAR_HEIGHT DECIMAL(5,2) NOT NULL
);

CREATE TABLE Pharmacist(
  PMC_LICENSE_ID NCHAR(7) PRIMARY KEY NOT NULL,
  PMC_NAME NVARCHAR(20) NOT NULL,
  PMC_SURNAME NVARCHAR(20) NOT NULL,
  PMC_GENDER NVARCHAR(6) NOT NULL,
  PMC_BIRTHDATE DATE NOT NULL,
  PMC_ADDRESS NVARCHAR(100) NOT NULL,
  PMC_PHONENUM NCHAR(10) NOT NULL,
  PMC_EMAIL NVARCHAR(30) NOT NULL,
  PMC_IDCARD NCHAR(13) NOT NULL
);

CREATE TABLE Department(
  DEPT_ID NCHAR(9) PRIMARY KEY NOT NULL,
  DEPT_NAME NVARCHAR(20) NOT NULL,
  DEPT_PHONE NCHAR(10) NOT NULL,
  DEPT_LOCATION NVARCHAR(50) NOT NULL
);

CREATE TABLE Doctor(
  DOC_LICENSE_ID NVARCHAR(10) PRIMARY KEY NOT NULL,
  DOC_IDCARD NCHAR(13) NOT NULL,
  DOC_NAME NVARCHAR(20) NOT NULL,
  DOC_SURNAME NVARCHAR(20) NOT NULL,
  DOC_GENDER NVARCHAR(6) NOT NULL,
  DOC_BIRTHDATE DATE NOT NULL,
  DOC_ADDRESS NVARCHAR(100) NOT NULL,
  DOC_EMAIL NVARCHAR(30) NOT NULL,
  DOC_PHONENUM NCHAR(10) NOT NULL
);

CREATE TABLE DoctorsOffice(
  DOC_OFF_ID NCHAR(8) PRIMARY KEY NOT NULL,
  DOC_OFF_EXAM TIME NOT NULL,
  DOC_OFF_DATE DATE NOT NULL,
  DOC_OFF_LOCATION NVARCHAR(50) NOT NULL
);

CREATE TABLE DrugandMedicalSupply(
  DMS_ID NCHAR(8) PRIMARY KEY NOT NULL,
  DWR_ID NCHAR(6) NOT NULL,
  DMS_GENERIC_NAME NVARCHAR(20) NOT NULL,
  DMS_TRADE_NAME NVARCHAR(20) NOT NULL,
  DMS_PRICE DECIMAL(8, 2) NOT NULL,
  DMS_DOSAGE DECIMAL(4, 2) NOT NULL,
  DMS_AMOUNT SMALLINT NOT NULL,
  DMS_UNIT NVARCHAR(30) NOT NULL,
  DMS_QTY_PER_UNIT TINYINT NOT NULL,
  DMS_EXP DATE NOT NULL,
  FOREIGN KEY (DWR_ID) REFERENCES DrugWarehouse(DWR_ID)
);

CREATE TABLE DrugandMedicalSupplyManagement(
  DMS_MAN_ID NCHAR(9) PRIMARY KEY NOT NULL,
  PMC_LICENSE_ID NCHAR(7) NOT NULL,
  DMS_ID NCHAR(8) NOT NULL,
  DMS_MAN_TIME DATETIME NOT NULL,
  FOREIGN KEY (PMC_LICENSE_ID) REFERENCES Pharmacist(PMC_LICENSE_ID),
  FOREIGN KEY (DMS_ID) REFERENCES DrugandMedicalSupply(DMS_ID)
);

CREATE TABLE PatientHealthInformation(
  PAR_IDCARD NCHAR(13) PRIMARY KEY NOT NULL,
  PAR_HE_DISEASE NVARCHAR(40),
  PAR_HE_DRUG_ALLERGY NVARCHAR(40),
  PAR_HE_ILLNESS_REC NVARCHAR(60),
  FOREIGN KEY (PAR_IDCARD) REFERENCES PatientRegistration(PAR_IDCARD)
);

CREATE TABLE Workinformation(
  WORK_ID NCHAR(9) PRIMARY KEY NOT NULL,
  DEPT_ID NCHAR(9) NOT NULL,
  PMC_LICENSE_ID NCHAR(7) NOT NULL,
  WORK_TIME DATETIME NOT NULL,
  FOREIGN KEY (DEPT_ID) REFERENCES Department(DEPT_ID),
  FOREIGN KEY (PMC_LICENSE_ID) REFERENCES Pharmacist(PMC_LICENSE_ID)
);

CREATE TABLE DrugShelf(
  SHELF_ID NCHAR(7) PRIMARY KEY NOT NULL,
  DEPT_ID NCHAR(9) NOT NULL,
  DMS_ID NCHAR(8),
  SHELF_CAPACITY TINYINT NOT NULL,
  FOREIGN KEY (DEPT_ID) REFERENCES Department(DEPT_ID),
  FOREIGN KEY (DMS_ID) REFERENCES DrugandMedicalSupply(DMS_ID)
);

CREATE TABLE DoctorLicense(
  DOC_LICENSE_ID NVARCHAR(10) PRIMARY KEY NOT NULL,
  DOC_LICENSE_SPEC NVARCHAR(25) NOT NULL,
  DOC_LICENSE_DEPT NVARCHAR(15),
);

CREATE TABLE MedicalRecord(
  MREC_ID NCHAR(12) PRIMARY KEY NOT NULL,
  PAR_IDCARD NCHAR(13) NOT NULL,
  DOC_LICENSE_ID NVARCHAR(10) NOT NULL,
  MREC_DATE DATE NOT NULL,
  MREC_SYMPTOMS NVARCHAR(100) NOT NULL,
  MREC_ADVICE NVARCHAR(100),
  FOREIGN KEY (PAR_IDCARD) REFERENCES PatientRegistration(PAR_IDCARD),
  FOREIGN KEY (DOC_LICENSE_ID) REFERENCES Doctor(DOC_LICENSE_ID)
);

CREATE TABLE Prescription(
  PRES_ID NCHAR(11) PRIMARY KEY NOT NULL,
  PAR_IDCARD NCHAR(13) NOT NULL,
  DOC_LICENSE_ID NVARCHAR(10) NOT NULL,
  PRES_MEDNAME NVARCHAR(50) NOT NULL,
  PRES_MEDTYPE NVARCHAR(50) NOT NULL,
  PRES_MEDQTY TINYINT NOT NULL,
  PRES_DATE DATE NOT NULL,
  FOREIGN KEY (PAR_IDCARD) REFERENCES PatientRegistration(PAR_IDCARD),
  FOREIGN KEY (DOC_LICENSE_ID) REFERENCES Doctor(DOC_LICENSE_ID)
);

CREATE TABLE PrescriptionManagement(
  PRES_MAN_ID NCHAR(12) PRIMARY KEY NOT NULL,
  DOC_LICENSE_ID NVARCHAR(10) NOT NULL,
  PRES_ID NCHAR(11) NOT NULL,
  PRES_MAN_TIME DATETIME NOT NULL,
  FOREIGN KEY (DOC_LICENSE_ID) REFERENCES Doctor(DOC_LICENSE_ID),
  FOREIGN KEY (PRES_ID) REFERENCES Prescription(PRES_ID)
);

CREATE TABLE DispensingRecordManagement(
  DISP_REC_MAN_ID NCHAR(12) PRIMARY KEY NOT NULL,
  PRES_ID NCHAR(11) NOT NULL,
  PMC_LICENSE_ID NCHAR(7) NOT NULL,
  DISP_REC_MAN_TIME DATETIME NOT NULL,
  FOREIGN KEY (PRES_ID) REFERENCES Prescription(PRES_ID),
  FOREIGN KEY (PMC_LICENSE_ID) REFERENCES Pharmacist(PMC_LICENSE_ID)
);

CREATE TABLE DispensingRecord(
  PRES_ID NCHAR(11) PRIMARY KEY NOT NULL,
  PMC_LICENSE_ID NCHAR(7) NOT NULL,
  DISP_REC_DATE DATE NOT NULL,
  FOREIGN KEY (PRES_ID) REFERENCES Prescription(PRES_ID),
  FOREIGN KEY (PMC_LICENSE_ID) REFERENCES Pharmacist(PMC_LICENSE_ID)
);
