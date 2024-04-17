/*
 * Copyright (c) 2023, Salesforce, Inc.
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
 * This apex code will add rows to the IsSTPApplication Decision Matrix
 * Usage:
 * From project root dir: sf apex run --file apex/StraightThroughProcessing.apex -o YourOrgAlias
 */ 

CalculationMatrixVersion calculationMatrixVersion = [SELECT Id FROM CalculationMatrixVersion WHERE ApiName = 'IsSTPApplication_V1'];
String calculationMatrixVersionId = calculationMatrixVersion.Id;
List<CalculationMatrixRow> rows = new List<CalculationMatrixRow>();

Map<String, Object> inputMap = new Map<String, Object>{ 'CreditScore' => 0 };
Map<String, Object> outputMap = new Map<String, Object>{ 'IsSTP' => false };
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = calculationMatrixVersionId,
                                    InputData = JSON.serialize(inputMap),
                                    OutputData = JSON.serialize(outputMap)));

inputMap.put('CreditScore', 740);
outputMap.put('IsSTP', true);
rows.add(new CalculationMatrixRow(CalculationMatrixVersionId = calculationMatrixVersionId,
                                    InputData = JSON.serialize(inputMap),
                                    OutputData = JSON.serialize(outputMap)));

insert rows;

calculationMatrixVersion.IsEnabled = true;
calculationMatrixVersion.Rank = 1;
update calculationMatrixVersion;