select DMS_MAN_ID as 'รหัสอ้างอิงการจัดการ', -- แสดงข้อมูลเภสัชที่ทำหน้าที่เป็นคนจัดการยาและเวชภัณฑ์มีชื่อว่าอะไรและจัดการวันเวลาไหน
    PMC_NAME as 'ชื่อเภสัชที่จัดการ' ,
    DMS_GENERIC_NAME as 'ชื่อยาสามัญ' ,
    DMS_TRADE_NAME as 'ชื่อยาทางการค้า' ,
    DMS_MAN_TIME as 'วันเดือนปี-เวลาที่ดำเนินการ'
from DrugandMedicalSupplyManagement 
inner join Pharmacist on DrugandMedicalSupplyManagement.PMC_LICENSE_ID = Pharmacist.PMC_LICENSE_ID 
inner join DrugandMedicalSupply on DrugandMedicalSupplyManagement.DMS_ID = DrugandMedicalSupply.DMS_ID ;

SELECT PAR_IDCARD as 'บัตรประจำตัวประชาชน', -- แสดงข้อมูลทั่วไปของผู้ป่วยทั้งหมด
	PAR_NAME as 'ชื่อ' ,
    PAR_SURNAME as 'นามสกุล' ,
    PAR_GENDER as 'เพศ',
    PAR_PER_PHONE as 'เบอร์ติดต่อ (ส่วนตัว)',
    PAR_WEIGHT as 'น้ำหนัก',
    PAR_HEIGHT as 'ส่วนสูง'
from PatientRegistration ;

SELECT PAR_NAME as 'ชื่อ' , -- แสดงข้อมูลโรคประจำตัวของผู้ป่วยที่ชื่อ ภาริน
    PAR_SURNAME as 'นามสกุล' ,
	PAR_HE_DISEASE as 'โรคประจำตัว'
FROM PatientRegistration 
inner join PatientHealthInformation on PatientRegistration.PAR_IDCARD = PatientHealthInformation.PAR_IDCARD
where PAR_NAME = N'ภาริน' ;

SELECT PAR_NAME as 'ชื่อ' , -- แสดงข้อมูลการแพ้ยาของผู้ป่วยที่ชื่อ ชาติ
    PAR_SURNAME as 'นามสกุล' ,
	PAR_HE_DRUG_ALLERGY as 'การแพ้ยา'
FROM PatientRegistration 
inner join PatientHealthInformation on PatientRegistration.PAR_IDCARD = PatientHealthInformation.PAR_IDCARD
where PAR_NAME = N'ชาติ' ;

SELECT PAR_IDCARD as 'บัตรประจำตัวประชาชน', -- แสดงข้อมูลทั่วไปของผู้ป่วยที่มีน้ำหนักตั้งแต่ 10 ถึง 60
	PAR_NAME as 'ชื่อ' ,
    PAR_SURNAME as 'นามสกุล' ,
    PAR_GENDER as 'เพศ',
    PAR_BIRTHDATE as 'วันเดือนปีเกิด',
    PAR_PER_PHONE as 'เบอร์ติดต่อ (ส่วนตัว)',
    PAR_WEIGHT as 'น้ำหนัก',
    PAR_HEIGHT as 'ส่วนสูง'
from PatientRegistration 
WHERE PAR_WEIGHT BETWEEN 10 AND 60;

SELECT WORK_ID as 'รหัสหน้าที่งาน' , -- แสดงข้อมูลแผนกและแสดงช่วงเวลาในการเข้าทำงานของเภสัชทุกคน
    PMC_NAME as 'ชื่อ' ,
    PMC_SURNAME as 'นามสกุล' ,
    DEPT_NAME as 'ชื่อแผนก' ,
	WORK_TIME as 'เวลาในการเข้าทำงาน'
FROM Workinformation
inner join Department on Workinformation.DEPT_ID = Department.DEPT_ID
inner join Pharmacist on Workinformation.PMC_LICENSE_ID = Pharmacist.PMC_LICENSE_ID ;

SELECT DOC_LICENSE_ID as 'เลขประกอบวิชาชีพแพทย์', -- แสดงข้อมูลทั่วไปของแพทย์ทุกคน
	DOC_NAME as 'ชื่อ' ,
    DOC_SURNAME as 'นามสกุล' ,
    DOC_GENDER as 'เพศ',
    DOC_BIRTHDATE as 'วันเดือนปีเกิด',
    DOC_EMAIL as 'อีเมล์',
    DOC_PHONENUM as 'เบอร์ติดต่อ'
from Doctor ;

SELECT DOC_NAME as 'ชื่อ' , -- แสดงข้อมูลสาขาความเชี่ยวชาญของแพทย์ทุกคน 
    DOC_SURNAME as 'นามสกุล' ,
	DOC_LICENSE_SPEC as 'สาขาที่เชี่ยวชาญ'
from Doctor 
inner join DoctorLicense on Doctor.DOC_LICENSE_ID = DoctorLicense.DOC_LICENSE_ID ;

SELECT MREC_ID as 'เลขที่บันทึกการรักษา' , -- แสดงข้อมูลชื่อแพทย์และวันที่ที่ทำการรักษาผู้ป่วย
	DOC_NAME as 'ชื่อ(หมอ)' ,
    PAR_NAME as 'ชื่อ(คนไข้)' ,
    PAR_SURNAME 'ชื่อ(คนไข้)' ,
    MREC_DATE as 'วันเดือนปีที่รักษา' ,
	MREC_SYMPTOMS as 'อาการที่พบ' 
from MedicalRecord 
inner join PatientRegistration on MedicalRecord.PAR_IDCARD  = PatientRegistration.PAR_IDCARD 
inner join Doctor on MedicalRecord.DOC_LICENSE_ID = Doctor.DOC_LICENSE_ID ;

SELECT PRES_ID as 'เลขที่ใบสั่งยา' , -- แสดงข้อมูลเกี่ยวกับการสั่งยาโดยแพทย์คนไหนและวันที่เท่าไหร่
	DOC_NAME as 'ชื่อ(หมอ)' ,
    PAR_NAME as 'ชื่อ(คนไข้)' ,
    PAR_SURNAME 'ชื่อ(คนไข้)' ,
    PRES_MEDNAME as 'ชื่อยาที่สั่ง' ,
	PRES_MEDTYPE as 'ชนิดยาที่สั่ง' ,
    PRES_MEDQTY as 'จำนวนยาที่สั่ง',
    PRES_DATE as 'วันเดือนปีที่สั่งยา'
from Prescription
inner join PatientRegistration on Prescription.PAR_IDCARD = PatientRegistration.PAR_IDCARD 
inner join Doctor on Prescription.DOC_LICENSE_ID = Doctor.DOC_LICENSE_ID ;