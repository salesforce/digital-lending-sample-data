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

ProductCategoryProduct sample_productCategoryProduct =
    new ProductCategoryProduct(
                            ProductCategoryId = sample_category.ID, ProductId = sample_product_auto_loan.ID);

insert sample_productCategoryProduct;
System.debug(sample_productCategoryProduct);
System.debug('Assign sample_product_auto_loan to sample_category');



