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
 * This apex code will delete data
 * Usage:
 * From project root dir: sf apex run --file apex/RemoveData.apex -o YourOrgAlias
 */

delete [SELECT Id FROM ProductListRate];

delete [SELECT Id FROM ProductFee];
 
delete [SELECT Id FROM ProductClassificationAttr];

delete [SELECT Id FROM Product2];

delete [SELECT Id FROM ProductClassification];

delete [SELECT Id FROM AttributeDefinition];

delete [SELECT Id FROM AttributePicklistValue];

delete [SELECT Id FROM AttributePicklist];

delete [SELECT Id FROM ProductCategoryProduct];

delete [SELECT Id FROM ProductCategory];

delete [SELECT Id FROM ProductCatalog];

List<DataUsePurpose> dups = [SELECT Id FROM DataUsePurpose];
for (DataUsePurpose dup : dups) {
    dup.IsActive = false;
}
update dups;

delete [SELECT Id FROM AuthorizationFormDataUse];

delete [SELECT Id FROM AuthorizationFormText];

delete [SELECT Id FROM AuthorizationForm];

delete [SELECT Id FROM DataUsePurpose];

List<CalculationMatrixVersion> versions = [SELECT Id FROM CalculationMatrixVersion];
for (CalculationMatrixVersion version : versions) {
    version.IsEnabled = false;
}
update versions;
delete [SELECT Id FROM CalculationMatrixRow];

delete [SELECT Id FROM DocumentTemplate];