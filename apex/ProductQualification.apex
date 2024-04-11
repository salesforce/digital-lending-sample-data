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
 * This apex code will create 2 product qualification records which are used by
 * the ProductQualificationDT decision table.
 * Usage:
 * Execute this script after ProductConfiguration.apex
 * Copy the auto loan product id and personal loan product id, and replace it at REPLACEME
 * From project root dir: sf apex run --file apex/ProductQualification.apex -o YourOrgAlias
 */ 

System.debug('Creating product qualification ...');

String autoLoanProductId = 'REPLACME';
String presonalLoanProductId = 'REPLACME';

// Merged with Products

ProductQualification autoLoanQualification = 
    new ProductQualification(ProductId = autoLoanProductId,
                             EffectiveFromDate = Date.newInstance(2023, 1, 1),
                             EffectiveToDate = Date.newInstance(2030, 12, 31),
                             City__c = 'Frisco');
insert autoLoanQualification;

ProductQualification personalLoanQualification = 
    new ProductQualification(ProductId = presonalLoanProductId,
                             EffectiveFromDate = Date.newInstance(2023, 1, 1),
                             EffectiveToDate = Date.newInstance(2030, 12, 31),
                             City__c = 'Pleasanton');
insert personalLoanQualification;

System.debug(autoLoanQualification.id);
System.debug(personalLoanQualification.id);
System.debug('Created 2 product qualifications');