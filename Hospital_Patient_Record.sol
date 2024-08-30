//SPDX-License-Identifier:MIT
pragma solidity >=0.8.12;
contract PatientRecord{
address admin;
constructor(){
admin=msg.sender;
}
modifier OnlyAdmin(){
require(msg.sender==admin, " Unauthorized access to the portal");
_;
}
struct Doctor{
string name; uint8 ID; string qualification;
string workplaceaddress;
}
struct Patient{
string name; uint8 ID; uint8 age; string[] disease;
}
struct Medicine{
uint8 ID; string name; string expirydate; string dose; uint256 price;
}
Doctor private doctor;
Doctor[] private doctor_details;
Patient private patient;
Patient[] private patient_details;
Medicine private medicine;
Medicine[] private medicine_details;
//function to register a new doctor and only admin can add a doctor to the portal
function register_doctor(string memory _name, uint8 _ID, string memory _qualification, string memory _workplaceaddress)public OnlyAdmin {
doctor.name=_name;
doctor.ID=_ID;
doctor.qualification=_qualification;
doctor.workplaceaddress=_workplaceaddress;
doctor_details.push(doctor);
}
//function to register a new patient and only admin can add
function register_patient(string memory _name,uint8 _ID, uint8 _age) public OnlyAdmin{
patient.name=_name;
patient.ID=_ID;
patient.age=_age;
patient_details.push(patient);
}
function add_patient_disease(uint8 _patientID, string memory _disease) public OnlyAdmin{
patient_details[_patientID].disease.push(_disease); // create an array of disease as a patient can have multiple diseases
}
function add_medicine_details(uint8 _ID, string memory _name, string memory _expirydate, string memory _dose, uint256 _price) public OnlyAdmin{
medicine.ID=_ID;
medicine.name=_name;
medicine.expirydate=_expirydate;
medicine.dose=_dose;
medicine.price=_price;
medicine_details.push(medicine);
}
// created a mapping to store prescribed medicine(s) to a patient to their address
mapping(address=> uint8) private PrescribeMedicine;
function prescribe_medicine(uint8 _medicineID, address _patientaddress) public{
PrescribeMedicine[_patientaddress]=_medicineID;
}
//function to update the age of patient
function update_patientage(uint8 _age, uint8 patientID) public OnlyAdmin{
patient_details[patientID].age=_age;
}
// function to get a patient's data
function get_patientdetails(uint8 _patientID) public view returns(Patient memory) {
return(patient_details[_patientID]);
}
//function to get medicine details
function get_medicinedetails(uint8 _medicineID) public view returns(Medicine memory){
return(medicine_details[_medicineID]);
}
// function to view presribed medcine to a patient
function view_prescribedmedicine(address _patientaddress) public view returns(uint8){
return(PrescribeMedicine[_patientaddress]);
}
//function to view a doctor's details
function get_doctordetails(uint8 _doctorID) public view returns(Doctor memory){
return(doctor_details[_doctorID]);
}
}
