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
 * This apex code will create 2 product qualification records which are used by
 * the ProductQualificationDT decision table.
 * Usage:
 * Execute this script after ProductConfiguration.apex
 * Copy the auto loan product id and personal loan product id, and replace it at REPLACEME
 * From project root dir: sf apex run --file apex/DisclosureAndConsent.apex -o YourOrgAlias
 */ 

DataUsePurpose dup = new DataUsePurpose();
dup.Name = 'AutoLoanData';
dup.Description = 'Auto Loan Data';
insert dup;

AuthorizationForm af = new AuthorizationForm();
af.Name = 'AuthorizationForm';
insert af;

AuthorizationFormText aft = new AuthorizationFormText();
aft.AuthorizationFormId = af.Id;
aft.SummaryAuthFormText = 'Credit Check Detailed Summary';
aft.Locale = 'en_US';
aft.LocaleSelection = 'en_US';
aft.Name = 'AuthorizationFormText_DL';
insert aft;

authorizationForm.DefaultAuthFormTextId = aft.Id;
update authorizationForm;

AuthorizationFormDataUse afdu = new AuthorizationFormDataUse();
afdu.DataUsePurposeId = dup.Id;
afdu.AuthorizationFormId = af.Id;
insert afdu;

dup.IsActive = true;
update dup;
