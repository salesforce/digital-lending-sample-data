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

// Create Products etc.
System.debug('Creating catalog...');

ProductCatalog sample_catalog = 
    new ProductCatalog(Name = 'sample_catalog',
                             Description = 'sample_catalog');
insert sample_catalog;

System.debug(sample_catalog);
System.debug('Created 1 product catalog');

System.debug('Creating category...');

ProductCategory sample_category =
    new ProductCategory(Name= 'sample_category',
                            Description = 'sample_category', CatalogId = sample_catalog.ID);

insert sample_category;

System.debug(sample_category);
System.debug('Created 1 product category');

System.debug('Creating product...');

Product2 sample_product_auto_loan =
    new Product2(Name= 'sample_product_auto_loan',
                            Description = 'sample_product_auto_loan', IsActive=True);

insert sample_product_auto_loan;

System.debug(sample_product_auto_loan);
System.debug('Created 1 product');

System.debug('Assigning sample_product_auto_loan to sample_category...');

ProductCategoryProduct sample_productCategoryProduct =
    new ProductCategoryProduct(
                            ProductCategoryId = sample_category.ID, ProductId = sample_product_auto_loan.ID);

insert sample_productCategoryProduct;
System.debug(sample_productCategoryProduct);
System.debug('Assigned sample_product_auto_loan to sample_category');

System.debug('Creating attribute definitions...');

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
    new AttributePicklistValue(Name = '12 Months', DisplayValue= '12', isDefault=True, Status= 'Active', Sequence = 1);

insert loanTerm_12Months;

System.debug(loanTerm_12Months);

AttributePicklistValue loanTerm_24Months =
    new AttributePicklistValue(Name = '24 Months', DisplayValue= '24', Status= 'Active', Sequence = 2);

insert loanTerm_24Months;

System.debug(loanTerm_24Months);

AttributePicklistValue loanTerm_36Months =
    new AttributePicklistValue(Name = '36 Months', DisplayValue= '36', Status= 'Active', Sequence = 3);

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











