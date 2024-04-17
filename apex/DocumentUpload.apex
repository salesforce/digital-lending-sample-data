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
 * This apex code will add rows to the LendingDocumentTypes Decision Matrix
 * Usage:
 * From project root dir: sf apex run --file apex/Document.apex -o YourOrgAlias
 */ 

String PREFIX = 'sample_';

String calculationMatrixVersionId = [SELECT Id FROM CalculationMatrixVersion WHERE ApiName = 'LendingDocumentTypes_V1'].Id;
String productId = [SELECT Id FROM Product2 WHERE Name =: PREFIX + 'product_auto_loan'].Id;
List<String> applicantTypes = new List<String> {'Primary Applicant', 'Guarantor', 'Co-Signer', 'Co-Applicant'};
List<CalculationMatrixRow> rows = new List<CalculationMatrixRow>();

for (String applicantType: applicantTypes) {

    Map<String, Object> inputMap = new Map<String, Object>{
        'productId' => productId,
        'applicantType' => applicantType,
        'level' => 'ApplicationFormProduct'
    };
    String inputData = JSON.serialize(inputMap);

    Map<String, Object> outputMap = new Map<String, Object>{
        'docTypeLabel' => (applicantType == 'Primary Applicant' ? 'Driving_License,Passport': 'Driving_License')
    };
    String outputData = JSON.serialize(outputMap);

    rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = calculationMatrixVersionId,
                                      InputData = inputData,
                                      OutputData = outputData));
}

insert rows;

