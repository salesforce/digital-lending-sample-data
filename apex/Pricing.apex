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
 * This apex code will populate sample data for pricing.
 * Usage:
 * From project root dir: sf apex run --file apex/Pricing.apex -o YourOrgAlias
 */

String PREFIX = 'sample';

List<Product2> products = [SELECT Id FROM Product2 WHERE Name =: PREFIX + '_product_auto_loan'];
String productId = products.get(0).Id;

RateAdjustmentByCreditScore__c rateAdjustmentByCreditScore1 =
    new RateAdjustmentByCreditScore__c(Product__c = productId, LowerBound__c = 801, UpperBound__c = 900, TierValue__c = 50, TierType__c = 'Percentage');

insert rateAdjustmentByCreditScore1;

System.debug(rateAdjustmentByCreditScore1);

RateAdjustmentByCreditScore__c rateAdjustmentByCreditScore2 =
    new RateAdjustmentByCreditScore__c(Product__c = productId, LowerBound__c = 701, UpperBound__c = 800, TierValue__c = 10, TierType__c = 'Percentage');

insert rateAdjustmentByCreditScore2;

System.debug(rateAdjustmentByCreditScore2);

RateAdjustmentByCreditScore__c rateAdjustmentByCreditScore3 =
    new RateAdjustmentByCreditScore__c(Product__c = productId, LowerBound__c = 601, UpperBound__c = 700, TierValue__c = 5, TierType__c = 'Percentage');

insert rateAdjustmentByCreditScore3;

System.debug(rateAdjustmentByCreditScore3);

RateAdjustmentByCreditScore__c rateAdjustmentByCreditScore4 =
    new RateAdjustmentByCreditScore__c(Product__c = productId, LowerBound__c = 0, UpperBound__c = 600, TierValue__c = 20, TierType__c = 'Override');

insert rateAdjustmentByCreditScore4;

System.debug(rateAdjustmentByCreditScore4);

RateAdjustmentByTerm__c rateAdjustmentByTerm1 =
    new RateAdjustmentByTerm__c(Product__c = productId, Term__c = 36, TierValue__c = 40, TierType__c = 'Percentage');

insert rateAdjustmentByTerm1;

System.debug(rateAdjustmentByTerm1);

RateAdjustmentByTerm__c rateAdjustmentByTerm2 =
    new RateAdjustmentByTerm__c(Product__c = productId, Term__c = 24, TierValue__c = 3, TierType__c = 'Amount');

insert rateAdjustmentByTerm2;

System.debug(rateAdjustmentByTerm2);

RateAdjustmentByTerm__c rateAdjustmentByTerm3 =
    new RateAdjustmentByTerm__c(Product__c = productId, Term__c = 12, TierValue__c = 4, TierType__c = 'Percentage');

insert rateAdjustmentByTerm3;

System.debug(rateAdjustmentByTerm3);
