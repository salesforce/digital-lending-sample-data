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
 * This apex code activates document templates and adds rows to the Get_Document_Template_from_Product decision matrix.
 * Creates an Object State Transition record.
 * Usage:
 * From project root dir: sf apex run --file apex/Contract.apex -o YourOrgAlias
 */ 

String PREFIX = 'sample_';

List<DocumentTemplate> templates = [SELECT Id, IsActive, Name FROM DocumentTemplate WHERE Name IN ('SAMPLE_LoanApprovalTemplate', 'SAMPLE_LoanRejectionTemplate')];
String rejectionTemplateId;
String approvalTemplateId;
for (DocumentTemplate template: templates) {
    template.IsActive = true;
    if (template.Name == 'SAMPLE_LoanRejectionTemplate') {
        rejectionTemplateId = template.Id;
    } else {
        approvalTemplateId = template.Id;
    }
}
update templates;

String calculationMatrixVersionId = [SELECT Id FROM CalculationMatrixVersion WHERE ApiName = 'Get_Document_Template_from_Product_V1'].Id;
String productId = [SELECT Id FROM Product2 WHERE Name =: PREFIX + 'product_auto_loan'].Id;
List<String> statuses = new List<String> {'Underwriter Rejected', 'Customer Rejected', 'Contract Generation'};
List<CalculationMatrixRow> rows = new List<CalculationMatrixRow>();

Map<String, Object> inputMap = new Map<String, Object>{
    'ProductId' => productId,
    'Status' => 'Underwriter Rejected'
};
String inputData = JSON.serialize(inputMap);
Map<String, Object> outputMap = new Map<String, Object>{
    'DocumentTemplate' => 'SAMPLE_LoanRejectionTemplate',
    'DocumentTemplateId' => rejectionTemplateId
};
String outputData = JSON.serialize(outputMap);
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = calculationMatrixVersionId,
                                      InputData = inputData,
                                      OutputData = outputData));

inputMap.put('Status', 'Customer Rejected');
inputData = JSON.serialize(inputMap);
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = calculationMatrixVersionId,
                                      InputData = inputData,
                                      OutputData = outputData));

inputMap.put('Status', 'Contract Generation');
inputData = JSON.serialize(inputMap);
outputMap.put('DocumentTemplate', 'SAMPLE_LoanApprovalTemplate');
outputMap.put('DocumentTemplateId', approvalTemplateId);
outputData = JSON.serialize(outputMap);
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = calculationMatrixVersionId,
                                      InputData = inputData,
                                      OutputData = outputData));

insert rows;

//Set objectStateDefinition status to not active
List<ObjectStateDefinition> objectStateDefinitions = [SELECT Id, IsActive FROM ObjectStateDefinition WHERE Name = 'Contract LifeCycle Management'];
objectStateDefinitions.get(0).IsActive = false;
update objectStateDefinitions;


List<ObjectStateValue> objectStateValueDraft = [SELECT Id, Name FROM ObjectStateValue WHERE Name = 'Draft'];
List<ObjectStateValue> objectStateValueAwaitingSignature = [SELECT Id, Name FROM ObjectStateValue WHERE Name = 'Awaiting Signature'];

// Insert objectStateTransition
List<ObjectStateTransition> objectStateTransitions = new List<ObjectStateTransition>();
objectStateTransitions.add(new ObjectStateTransition(Name = 'Draft_To_AwaitingSignature',
                                ObjectStateDefinitionId = objectStateDefinitions.get(0).Id,
                                FromStateId = objectStateValueDraft.get(0).Id,
                                ToStateId = objectStateValueAwaitingSignature.get(0).Id));
insert objectStateTransitions;

//Set objectStateDefinition status to active
objectStateDefinitions.get(0).IsActive = true;
update objectStateDefinitions;