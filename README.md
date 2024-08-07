# README

This repository contains sample data for Industries Digital Lending.

Digital Lending feature setup has several steps. This repo automates many of these setup steps and will also setup sample data (i.e. products etc.)


## Usage

### Prerequisites and Guidelines

1. Run all the following steps on a fresh org (i.e. any newly created org without additional data).
2. The setup is divided into several sections. Digital Lending relies on several Salesforce features and each section will complete setup for a subset of the features.
3. The setup will create data, for e.g. Product. Running the same command again might lead to duplicate data.
4. The org should have all the appropriate licenses so that Digital Lending feature is available on your org. The setup will help you assign appropriate permission sets etc.
5. The setup assumes that the user has latest `sf` (Salesforce-CLI) installed. It also assumes general familiarity with Salesforce.
6. Ensure that Apex Debug Level is set to `DEBUG` or more verbose. This is required since some of the commands below will debug-print from Apex code. You will need to note certain data from these logs to be used in later steps.

Connect to your org using `sf org login web -a YourOrgAlias -r YOURURL` command.

### Org Setup

1. Run `sf apex run --file apex/OrgSetup.apex -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates a custom permission set SampleDigitalLendingClone. 

Assigns this and several other permission sets to the user.
</details>

2. Run `sf project deploy start --metadata-dir metadata/OrgSetup -o YourOrgAlias`
<details>
<summary>Command Details</summary>

Creates a custom field City on ProductQualification object.

Enables Context Definition, Salesforce Pricing and Industries KYC in the org.

Creates Sample Financial Services For Customer Community Plus Login Clone permission set

Adds picklist values for 
- Salutation field on Applicant
- Loan Purpose field on ApplicationFormProduct
- IncomeFrequency and IncomeType fields on PartyIncome
- Type and RecurrenceInterval fields on PartyExpense
- Nationality field on PartyProfile 
- Type field on Party Financial Asset

If you have existing active picklist values in your org for above picklists then you could add those to the standard value set to keep them active
</details>

3. Run `sf project deploy start --metadata-dir metadata/Profiles -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates a custom profile called Sample Customer Community Plus Login User Clone, adds object permissions and user permissions for community user

Assigns fieldpermissions to Admin and Sample Customer Community Plus Login User Clone profiles for the new custom field City.

Updated Sharing Settings to expose objects to community users
</details>

4. Navigate to `Product Discovery Settings` from Setup (`Feature Settings` &rarr; `Product Discovery` &rarr; `Product Discovery Settings`), and enable `Qualification Procedure`.

5. Navigate to `Digital Lending` from Setup (`Feature Settings` &rarr; `Lending` &rarr; `Digital Lending`), and enable `Digital Lending`.

In the above steps, new custom field `City__c` has been created on `ProductQualification` object, 
`Product__c`, `LowerBound__c`, `UpperBound__c`, `TierValue__c`, `TierType__c` has been created on `RateAdjustmentByCreditScore__c` and `Product__c`, `Term__c`, `TierValue__c`, `TierType__c` has been created on `RateAdjustmentByTerm__c`. 
We also assigned field permissions for two profiles. Assign field permissions to any other profiles you want these fields to be visible from Setup.

### Product Configuration

1. Run `sf apex run --file apex/ProductConfiguration.apex -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Create a product catalog record, a product category record associate with a product record.

Create five product attributes for this sample product according to the document.

Create product list rate record and product fee record for the sample product.

You could also add product image and turn on sharing settings for community user for this sample product by following the document. 

Creates a product qualification records.
</details>

### Product Qualification

1. Run `sf project deploy start --metadata-dir metadata/ProductQualificationSetup -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates a Decision Table for Product Qualification.
</details>

2. Run `sf project deploy start --metadata-dir metadata/ProductQualificationExpressionSet -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates two expression sets for Product Qualification.
</details>

### Disclosure And Consent

1. Run `sf project deploy start --metadata-dir metadata/DisclosureAndConsent -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates a Decision Matrix for Disclosure And Consent.
</details>

2. Run `sf apex run --file apex/DisclosureAndConsent.apex -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates Application Form, Application Form Text, Data Use Purpose, and ApplicationFormDataUse record.

Adds rows to the Decision Matrix for Disclosure And Consent.
</details>

### Document Upload

1. Run `sf project deploy start --metadata-dir metadata/DocumentUpload -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates a Decision Matrix for Document Upload.

Creates two Document Types.
</details>

2. Run `sf apex run --file apex/DocumentUpload.apex -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Adds rows to the Decision Matrix for Document Upload.
</details>

### Straight Through Processing

1. Run `sf project deploy start --metadata-dir metadata/StraightThroughProcessing -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates a Decision Matrix for Straight Through Processing.
</details>

2. Run `sf apex run --file apex/StraightThroughProcessing.apex -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Adds rows to the Decision Matrix for Straight Through Processing.

Activates Decision Matrix for Straight Through Processing.
</details>

### Pricing

1. Run `sf apex run --file apex/Pricing.apex -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Adds records in the custom objects for Pricing.
</details>

2. Run `sf project deploy start --metadata-dir metadata/PricingSetup -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates decision tables used for pricing.
</details>

3. Modify Price Adjustment Matrices using below steps
<details>
<summary>Steps to modify Price Adjustment Matrices</summary>

1. Go to Setup > Pricing Recipes > NGPDefaultRecipe > Select Price Adjustment Matrix tab > Click Modify 

2. Update CreditScoreBasedAdjustment's Variable Mapping to TierValue__c for AdjustmentValue and TierType__c for AdjustmentType

3. Select CreditScoreBasedAdjustment by clicking on the + button

4. Click Save

5. Click Modify

6. Update ProductListRateDT's Pricing Component Type to List Price and update the Variable Mapping to List Rate for UnitPrice

7. Select ProductListRateDT by clicking on the + button

8. Click Save

9. Click Modify

10. Update TermBasedAdjustmentDT's Variable Mapping to TierValue__c for AdjustmentValue and TierType__c for AdjustmentType

11. Select TermBasedAdjustmentDT by clicking on the + button

12. Click Save
</details>

4. Run `sf project deploy start --metadata-dir metadata/PricingExpressionSet -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates expression set definition used for pricing.
</details>

### Participant role for Compliant Data Sharing 

1. Navigate to `Compliant Data Sharing`'s `Object Enablement Settings` from Setup and enable `Compliant Data Sharing for CRM Users` for `Application Form` Object.

2. Run `sf project deploy start --metadata-dir metadata/CompliantDataSharing -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates Application Form Participant Role With Read/Write access level
</details>
