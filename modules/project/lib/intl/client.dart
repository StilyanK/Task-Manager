import 'package:intl/intl.dart';

String Request() => Intl.message('Request', name: 'Request');

String Processing() => Intl.message('Processing', name: 'Processing');

String Validated() => Intl.message('Validated', name: 'Validated');

String Finalized() => Intl.message('Finalized', name: 'Finalized');

String DoctorTitle(dynamic id) => (id != null) ? DoctorId(id) : DoctorNew();

String DoctorId(dynamic id) =>
    Intl.message('Doctor #$id', name: 'DoctorId', args: [id]);

String DoctorNew() => Intl.message('New doctor', name: 'DoctorNew');

String DoctorList() => Intl.message('Doctor list');

String PatientTitle(dynamic id) => (id != null) ? PatientId(id) : PatientNew();

String PatientId(dynamic id) =>
    Intl.message('Patient #$id', name: 'PatientId', args: [id]);

String PatientNew() => Intl.message('New patient', name: 'PatientNew');

String PatientList() => Intl.message('Patient list');

String PatientRecordTitle(dynamic id) =>
    (id != null) ? PatientRecordId(id) : PatientRecordNew();

String PatientRecordId(dynamic id) =>
    Intl.message('PatientRecord #$id', name: 'PatientRecordId', args: [id]);

String PatientRecordNew() =>
    Intl.message('New patient record', name: 'PatientRecordNew');

String PatientRecordList() => Intl.message('PatientRecord list');

String Name() => Intl.message('Name', name: 'Name');

String Doctor() => Intl.message('Doctor', name: 'Doctor');

String Patient() => Intl.message('Patient', name: 'Patient');

String Date() => Intl.message('Date', name: 'Date');

String Status() => Intl.message('Status', name: 'Status');

String Upload() => Intl.message('Upload', name: 'Upload');

String Documents() => Intl.message('Documents', name: 'Documents');

String Document() => Intl.message('Document', name: 'Document');

String Preview() => Intl.message('Preview', name: 'Preview');

String Comment() => Intl.message('Comment', name: 'Comment');

String Epicrisis() => Intl.message('Epicrisis', name: 'Epicrisis');

String PersonalId() => Intl.message('Personal id', name: 'PersonalId');

String NoDocuments() => Intl.message('No documents', name: 'NoDocuments');

String SomeDocuments() => Intl.message('Some documents', name: 'SomeDocuments');

String AllDocuments() => Intl.message('All documents', name: 'AllDocuments');

String Decline() => Intl.message('Decline', name: 'Decline');

String ReCheck() => Intl.message('Recheck', name: 'ReCheck');

String Approve() => Intl.message('Approve', name: 'Approve');

String Approvals() => Intl.message('Approvals', name: 'Approvals');

String Declined() => Intl.message('Declined', name: 'Declined');

String MustRecheck() => Intl.message('Must be rechecked', name: 'MustRecheck');

String Approved() => Intl.message('Approved', name: 'Approved');

String Commission() => Intl.message('Commission', name: 'Commission');

String CommissionNew() => Intl.message('New commission', name: 'CommissionNew');

String CommissionId(dynamic id) =>
    Intl.message('Commission #$id', name: 'CommissionId', args: [id]);

String CommissionTitle(dynamic id) =>
    (id != null) ? CommissionId(id) : CommissionNew();

String CommissionList() =>
    Intl.message('Commission list', name: 'CommissionList');

String ChooseCommission() =>
    Intl.message('Choose commission', name: 'ChooseCommission');

String Disease() => Intl.message('Disease', name: 'Disease');

String DiseaseNew() => Intl.message('New disease', name: 'DiseaseNew');

String DiseaseList() => Intl.message('Disease list', name: 'DiseaseList');

String DiseaseId(dynamic id) =>
    Intl.message('Disease #$id', name: 'DiseaseId', args: [id]);

String DiseaseTitle(dynamic id) => (id != null) ? DiseaseId(id) : DiseaseNew();

String ChooseDisease() => Intl.message('Choose disease', name: 'ChooseDisease');

String Link() => Intl.message('Link', name: 'Link');

String Comments() => Intl.message('Comments', name: 'Comments');

String Open() => Intl.message('Open', name: 'Open');

String Scratch() => Intl.message('Scratch', name: 'Scratch');

String AllDocsCollected() =>
    Intl.message('All documents are collected', name: 'AllDocsCollected');

String You() => Intl.message('You', name: 'You');

String Main() => Intl.message('Main', name: 'Main');

String Timing() => Intl.message('Timing', name: 'Timing');

String User() => Intl.message('User', name: 'User');

String DaysPassed() => Intl.message('Days passed', name: 'DaysPassed');

String Days() => Intl.message('Days', name: 'Days');

String For() => Intl.message('For', name: 'For');

String NotChecked() => Intl.message('Not checked', name: 'NotChecked');

String DocComments() => Intl.message('Document comments', name: 'DocComments');

String AddComment() => Intl.message('Add comment', name: 'AddComment');

String Add() => Intl.message('Add', name: 'Add');

String CommissionDoctors() =>
    Intl.message('Commission doctors', name: 'CommissionDoctors');

String Doctors() => Intl.message('Doctors', name: 'Doctors');

String SendToCommission() =>
    Intl.message('Send to commission', name: 'SendToCommission');

String CommissionIsReady() =>
    Intl.message('Commission is ready', name: 'CommissionIsReady');

String FinalizeDocument() =>
    Intl.message('Finalize document', name: 'FinalizeDocument');

String ESign() => Intl.message('E-Sign', name: 'ESign');

String MissingDocs() => Intl.message('Missing documents', name: 'MissingDocs');

String MotivationId(dynamic id) =>
    Intl.message('Motivation #$id', name: 'MotivationId', args: [id]);

String Type() => Intl.message('Type', name: 'Type');
