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

String SAMPLE_PREFIX = 'sample_';

ProductCatalog sample_catalog = 
    new ProductCatalog(Name = SAMPLE_PREFIX+'catalog',
                             Description = SAMPLE_PREFIX+'catalog');
insert sample_catalog;

System.debug(sample_catalog);

ProductCategory sample_category =
    new ProductCategory(Name= SAMPLE_PREFIX+'category',
                            Description = SAMPLE_PREFIX+'category', CatalogId = sample_catalog.ID);

insert sample_category;

System.debug(sample_category);

ProductClassification productClassification =
    new ProductClassification(Code = SAMPLE_PREFIX+'product_classification', Name=SAMPLE_PREFIX+'product_classification', status='Active');

insert productClassification;
System.debug(productClassification);

Product2 sample_product_auto_loan =
    new Product2(Name= SAMPLE_PREFIX+'product_auto_loan',
                            Description = SAMPLE_PREFIX+'product_auto_loan', IsActive=True, BasedOnId = productClassification.ID);

insert sample_product_auto_loan;

System.debug(sample_product_auto_loan);

ProductCategoryProduct sample_productCategoryProduct =
    new ProductCategoryProduct(
                            ProductCategoryId = sample_category.ID, ProductId = sample_product_auto_loan.ID);

insert sample_productCategoryProduct;
System.debug(sample_productCategoryProduct);

AttributeDefinition maxLoanAmount =
    new AttributeDefinition(Name = 'MaxLoanAmount', DataType='Number', DefaultValue='1000000', Description='MaxLoanAmount', Label= 'MaxLoanAmount', isActive=True);

insert maxLoanAmount;

System.debug(maxLoanAmount);

AttributeDefinition minLoanAmount =
    new AttributeDefinition(Name = 'MinLoanAmount', DataType='Number', DefaultValue='1000', Description='MinLoanAmount', Label= 'MinLoanAmount', isActive=True);

insert minLoanAmount;

System.debug(minLoanAmount);

AttributeDefinition omniscriptName =
    new AttributeDefinition(Name = 'OmniscriptName', DataType='Text', DefaultValue='ApplicantIntakeSecured', Description='OmniscriptName', Label= 'OmniscriptName', isActive=True);

insert omniscriptName;

System.debug(omniscriptName);

AttributePicklist attributePicklistLoanTerm =
    new AttributePicklist(Name = 'LoanTerm', Description='LoanTerm',  DataType='Text', Status = 'Active');

insert attributePicklistLoanTerm;

System.debug(attributePicklistLoanTerm);


AttributePicklistValue loanTerm_12Months =
    new AttributePicklistValue(Name = '12 Months',Code = '12',  Value= '12', isDefault=True, Status= 'Active', Sequence = 1, PicklistId= attributePicklistLoanTerm.ID);

insert loanTerm_12Months;

System.debug(loanTerm_12Months);

AttributePicklistValue loanTerm_24Months =
    new AttributePicklistValue(Name = '24 Months',Code = '24', Value= '24', Status= 'Active', Sequence = 2, PicklistId= attributePicklistLoanTerm.ID);

insert loanTerm_24Months;

System.debug(loanTerm_24Months);

AttributePicklistValue loanTerm_36Months =
    new AttributePicklistValue(Name = '36 Months',Code = '36', Value= '36', Status= 'Active', Sequence = 3, PicklistId= attributePicklistLoanTerm.ID);

insert loanTerm_36Months;

System.debug(loanTerm_36Months);

AttributeDefinition loanTerm =
    new AttributeDefinition(Name = 'LoanTerm', DataType='Picklist', Description='LoanTerm', Label= 'LoanTerm', isActive=True, PicklistId= attributePicklistLoanTerm.ID);

insert loanTerm;

System.debug(loanTerm);


AttributeDefinition offerValidPeriod =
    new AttributeDefinition(Name = 'OfferValidPeriod', DataType = 'Number', Label= 'OfferValidPeriod', Description='OfferValidPeriod', isActive=True, DefaultValue='30');

insert offerValidPeriod;
System.debug(offerValidPeriod);

ProductClassificationAttr productClassificationAttr =
    new ProductClassificationAttr(Name = 'MaxLoanAmount', AttributeDefinitionId = maxLoanAmount.ID, Status= 'Active', ProductClassificationId=productClassification.ID);

insert productClassificationAttr;
System.debug(productClassificationAttr);

productClassificationAttr =
    new ProductClassificationAttr(Name = 'MinLoanAmount', AttributeDefinitionId = minLoanAmount.ID, Status= 'Active', ProductClassificationId=productClassification.ID);

insert productClassificationAttr;
System.debug(productClassificationAttr);

productClassificationAttr =
    new ProductClassificationAttr(Name = 'OmniscriptName', AttributeDefinitionId = omniscriptName.ID, Status= 'Active', ProductClassificationId=productClassification.ID);

insert productClassificationAttr;
System.debug(productClassificationAttr);

productClassificationAttr =
    new ProductClassificationAttr(Name = 'LoanTerm', AttributeDefinitionId = loanTerm.ID, Status= 'Active', ProductClassificationId=productClassification.ID);

insert productClassificationAttr;
System.debug(productClassificationAttr);

productClassificationAttr =
    new ProductClassificationAttr(Name = 'OfferValidPeriod', AttributeDefinitionId = offerValidPeriod.ID, Status= 'Active', ProductClassificationId=productClassification.ID);

insert productClassificationAttr;
System.debug(productClassificationAttr);

System.debug('Creating product qualification ...');

String autoLoanProductId = sample_product_auto_loan.Id;

ProductQualification autoLoanQualification = 
    new ProductQualification(ProductId = autoLoanProductId,
                             EffectiveFromDate = Date.newInstance(2023, 1, 1),
                             EffectiveToDate = Date.newInstance(2030, 12, 31),
                             City__c = 'Frisco');
insert autoLoanQualification;
