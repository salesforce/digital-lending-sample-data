/*
 * Copyright (c) 2024, Salesforce, Inc.
 * SPDX-License-Identifier: Apache-2
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * This apex code will add rows to the AFPStage_To_AFStage, AFPStage_To_ApplicantVisibleStatus, 
 * and AFPStage_To_CDSAccess Decision Matrices
 * From project root dir: sf apex run --file apex/StageManagement.apex -o YourOrgAlias
 */ 

List<CalculationMatrixRow> rows = new List<CalculationMatrixRow>();

// Populate AFPStage_To_AFStage Decision Matrix
String afStageId = [SELECT Id FROM CalculationMatrixVersion WHERE ApiName = 'AFPStage_To_AFStage_V1'].Id;
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = afStageId,
                                    InputData = '{"ApplicationFormProductStage":"Book to Core"}',
                                    OutputData = '{"ApplicationFormStage":"Book to Core"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = afStageId,
                                    InputData = '{"ApplicationFormProductStage":"Signature Complete"}',
                                    OutputData = '{"ApplicationFormStage":"Closing"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = afStageId,
                                    InputData = '{"ApplicationFormProductStage":"Awaiting Signature"}',
                                    OutputData = '{"ApplicationFormStage":"Closing"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = afStageId,
                                    InputData = '{"ApplicationFormProductStage":"Contract Generation"}',
                                    OutputData = '{"ApplicationFormStage":"Closing"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = afStageId,
                                    InputData = '{"ApplicationFormProductStage":"Auto Rejected"}',
                                    OutputData = '{"ApplicationFormStage":"Decision"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = afStageId,
                                    InputData = '{"ApplicationFormProductStage":"Underwriter Rejected"}',
                                    OutputData = '{"ApplicationFormStage":"Decision"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = afStageId,
                                    InputData = '{"ApplicationFormProductStage":"Customer Rejected"}',
                                    OutputData = '{"ApplicationFormStage":"Decision"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = afStageId,
                                    InputData = '{"ApplicationFormProductStage":" Auto Approved"}',
                                    OutputData = '{"ApplicationFormStage":"Decision"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = afStageId,
                                    InputData = '{"ApplicationFormProductStage":"Customer Approved"}',
                                    OutputData = '{"ApplicationFormStage":"Decision"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = afStageId,
                                    InputData = '{"ApplicationFormProductStage":"Underwriter Approved"}',
                                    OutputData = '{"ApplicationFormStage":"Decision"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = afStageId,
                                    InputData = '{"ApplicationFormProductStage":"Need More Info"}',
                                    OutputData = '{"ApplicationFormStage":"Submitted"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = afStageId,
                                    InputData = '{"ApplicationFormProductStage":"In Review"}',
                                    OutputData = '{"ApplicationFormStage":"Submitted"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = afStageId,
                                    InputData = '{"ApplicationFormProductStage":"Submitted"}',
                                    OutputData = '{"ApplicationFormStage":"Submitted"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = afStageId,
                                    InputData = '{"ApplicationFormProductStage":"Intake"}',
                                    OutputData = '{"ApplicationFormStage":"Intake"}'));

// Populate Application_Visible_Status Decision Matrix
String appVisibleStatusId = [SELECT Id FROM CalculationMatrixVersion WHERE ApiName = 'AFPStage_To_ApplicantVisibleStatus_V1'].Id;
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = appVisibleStatusId,
                                    InputData = '{"ApplicationFormProductStage":"Book to Core"}',
                                    OutputData = '{"ApplicantVisibleStatus":"Loan Booked"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = appVisibleStatusId,
                                    InputData = '{"ApplicationFormProductStage":"Signature Complete"}',
                                    OutputData = '{"ApplicantVisibleStatus":"Signature Complete"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = appVisibleStatusId,
                                    InputData = '{"ApplicationFormProductStage":"Awaiting Signature"}',
                                    OutputData = '{"ApplicantVisibleStatus":"Awaiting Signature"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = appVisibleStatusId,
                                    InputData = '{"ApplicationFormProductStage":"Contract Generation"}',
                                    OutputData = '{"ApplicantVisibleStatus":"Contract Generation"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = appVisibleStatusId,
                                    InputData = '{"ApplicationFormProductStage":"Auto Rejected"}',
                                    OutputData = '{"ApplicantVisibleStatus":"Rejected"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = appVisibleStatusId,
                                    InputData = '{"ApplicationFormProductStage":"Underwriter Rejected"}',
                                    OutputData = '{"ApplicantVisibleStatus":"Rejected"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = appVisibleStatusId,
                                    InputData = '{"ApplicationFormProductStage":"Customer Rejected"}',
                                    OutputData = '{"ApplicantVisibleStatus":"Rejected"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = appVisibleStatusId,
                                    InputData = '{"ApplicationFormProductStage":"Auto Approved"}',
                                    OutputData = '{"ApplicantVisibleStatus":"Approved"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = appVisibleStatusId,
                                    InputData = '{"ApplicationFormProductStage":"Customer Approved"}',
                                    OutputData = '{"ApplicantVisibleStatus":"Approved"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = appVisibleStatusId,
                                    InputData = '{"ApplicationFormProductStage":"Underwriter Approved"}',
                                    OutputData = '{"ApplicantVisibleStatus":"Approved"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = appVisibleStatusId,
                                    InputData = '{"ApplicationFormProductStage":"Need More Info"}',
                                    OutputData = '{"ApplicantVisibleStatus":"Need More Info"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = appVisibleStatusId,
                                    InputData = '{"ApplicationFormProductStage":"In Review"}',
                                    OutputData = '{"ApplicantVisibleStatus":"In Review"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = appVisibleStatusId,
                                    InputData = '{"ApplicationFormProductStage":"Submitted"}',
                                    OutputData = '{"ApplicantVisibleStatus":"Submitted"}'));

//Populate AFPStage_To_CDSAccess Decision Matrix
String cdsAccessId = [SELECT Id FROM CalculationMatrixVersion WHERE ApiName = 'AFPStage_To_CDSAccess_V1'].Id;
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = cdsAccessId,
                                    InputData = '{"ApplicationFormProductStage":"Book to Core"}',
                                    OutputData = '{"Underwriter_Access":"ApplicationFormRW,ApplicationFormProductRW,PartyProfileRW","Applicant_Agent_Access":"ApplicationFormRead,ApplicationFormProductRead,PartyProfileRead"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = cdsAccessId,
                                    InputData = '{"ApplicationFormProductStage":"Signature Complete"}',
                                    OutputData = '{"Underwriter_Access":"ApplicationFormRW,ApplicationFormProductRW,PartyProfileRW","Applicant_Agent_Access":"ApplicationFormRead,ApplicationFormProductRead,PartyProfileRead"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = cdsAccessId,
                                    InputData = '{"ApplicationFormProductStage":"Awaiting Signature"}',
                                    OutputData = '{"Underwriter_Access":"ApplicationFormRW,ApplicationFormProductRW,PartyProfileRW","Applicant_Agent_Access":"ApplicationFormRead,ApplicationFormProductRead,PartyProfileRead"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = cdsAccessId,
                                    InputData = '{"ApplicationFormProductStage":"Contract Generation"}',
                                    OutputData = '{"Underwriter_Access":"ApplicationFormRW,ApplicationFormProductRW,PartyProfileRW","Applicant_Agent_Access":"ApplicationFormRead,ApplicationFormProductRead,PartyProfileRead"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = cdsAccessId,
                                    InputData = '{"ApplicationFormProductStage":"Auto Rejected"}',
                                    OutputData = '{"Underwriter_Access":"ApplicationFormNoAccess,ApplicationFormProductNoAccess,PartyProfileNoAccess","Applicant_Agent_Access":"ApplicationFormRead,ApplicationFormProductRead,PartyProfileRead"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = cdsAccessId,
                                    InputData = '{"ApplicationFormProductStage":"Underwriter Rejected"}',
                                    OutputData = '{"Underwriter_Access":"ApplicationFormRW,ApplicationFormProductRW,PartyProfileRW","Applicant_Agent_Access":"ApplicationFormRead,ApplicationFormProductRead,PartyProfileRead"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = cdsAccessId,
                                    InputData = '{"ApplicationFormProductStage":"Customer Rejected"}',
                                    OutputData = '{"Underwriter_Access":"ApplicationFormRW,ApplicationFormProductRW,PartyProfileRW","Applicant_Agent_Access":"ApplicationFormRead,ApplicationFormProductRead,PartyProfileRead"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = cdsAccessId,
                                    InputData = '{"ApplicationFormProductStage":"Auto Approved"}',
                                    OutputData = '{"Underwriter_Access":"ApplicationFormNoAccess,ApplicationFormProductNoAccess,PartyProfileNoAccess","Applicant_Agent_Access":"ApplicationFormRead,ApplicationFormProductRead,PartyProfileRead"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = cdsAccessId,
                                    InputData = '{"ApplicationFormProductStage":"Customer Approved"}',
                                    OutputData = '{"Underwriter_Access":"ApplicationFormRW,ApplicationFormProductRW,PartyProfileRW","Applicant_Agent_Access":"ApplicationFormRead,ApplicationFormProductRead,PartyProfileRead"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = cdsAccessId,
                                    InputData = '{"ApplicationFormProductStage":"Underwriter Approved"}',
                                    OutputData = '{"Underwriter_Access":"ApplicationFormRW,ApplicationFormProductRW,PartyProfileRW","Applicant_Agent_Access":"ApplicationFormRead,ApplicationFormProductRead,PartyProfileRead"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = cdsAccessId,
                                    InputData = '{"ApplicationFormProductStage":"Need More Info"}',
                                    OutputData = '{"Underwriter_Access":"ApplicationFormRW,ApplicationFormProductRW,PartyProfileRW","Applicant_Agent_Access":"ApplicationFormRead,ApplicationFormProductRead,PartyProfileRead"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = cdsAccessId,
                                    InputData = '{"ApplicationFormProductStage":"In Review"}',
                                    OutputData = '{"Underwriter_Access":"ApplicationFormRW,ApplicationFormProductRW,PartyProfileRW","Applicant_Agent_Access":"ApplicationFormRead,ApplicationFormProductRead,PartyProfileRead"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = cdsAccessId,
                                    InputData = '{"ApplicationFormProductStage":"Submitted"}',
                                    OutputData = '{"Underwriter_Access":"ApplicationFormRW,ApplicationFormProductRW,PartyProfileRW","Applicant_Agent_Access":"ApplicationFormRead,ApplicationFormProductRead,PartyProfileRead"}'));
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = cdsAccessId,
                                    InputData = '{"ApplicationFormProductStage":"Intake"}',
                                    OutputData = '{"Underwriter_Access":"ApplicationFormNoAccess,ApplicationFormProductNoAccess,PartyProfileNoAccess","Applicant_Agent_Access":"ApplicationFormRW,ApplicationFormProductRW,PartyProfileRW"}'));

insert rows;