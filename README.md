# README

This repository contains sample data for Industries Digital Lending.

Digital Lending feature setup has several steps. This repo automates many of these setup steps and will also setup sample data (i.e. products etc.)


## Usage

### Prerequisites and Guidelines

1. Run all the following steps on a fresh org (i.e. any newly created org without additional data).
2. The Digital Lending sample data in this repository is intended for non-production Salesforce orgs.
3. The setup is divided into several sections. Digital Lending relies on several Salesforce features and each section will complete setup for a subset of the features.
4. The setup will create data, for e.g. Product. Running the same command again might lead to duplicate data.
5. The org should have all the appropriate licenses so that Digital Lending feature is available on your org. The setup will help you assign appropriate permission sets etc.
6. The setup assumes that the user has latest `sf` (Salesforce-CLI) installed. It also assumes general familiarity with Salesforce.
7. Ensure that Apex Debug Level is set to `DEBUG` or more verbose. This is required since some of the commands below will debug-print from Apex code. You will need to note certain data from these logs to be used in later steps.

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
Creates custom profiles called Sample Customer Community Plus Login User Clone, Agent Digital Lending and Underwriter Digital Lending. Adds object and user permissions for these profiles.

Assigns field permission to these profiles for the new custom field City.

Updated Sharing Settings to expose objects to community users
</details>

In the above steps, new custom field `City__c` has been created on `ProductQualification` object and `SourceApplicationFormProduct__c` has been created on `Contract` object, 
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

3. Run `sf project deploy start --metadata-dir metadata/PricingRecipe -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates pricing recipe called DigitalLendingRecipe that provides configuration for how lookup tables are used within procedures 
</details>

4. Run `sf project deploy start --metadata-dir metadata/PricingExpressionSet -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates expression set definitions used for pricing.
</details>

### Participant role for Compliant Data Sharing 

1. Run `sf project deploy start --metadata-dir metadata/CompliantDataSharing -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates Application Form Participant Role With Read/Write access level
</details>

### Stage Management for Digital Lending 

1. Run `sf apex run --file apex/StageManagementGroupSetup.apex -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates 2 participant groups called Agent_Group and Underwriter_Group
</details>

2. Run `sf project deploy start --metadata-dir metadata/StageManagement -o YourOrgAlias`

<details>
<summary>Command Details</summary>
Adds Apex files, Decision Matrix Definition, Flow, and Participant Roles. CDSCacheHelper helps cache SOQL results. CDSUtil will be run as a stage transition step. When an Application Form Product's Stage field changes, the Visible Status field will change based on the decision matrix values. Additionally, the associated Application Form's Stage field will also change based on the decision matrix values. Afterwards, Participant records will be created on the Application Form Product, the associated Application Form record, and the associated Party Profile record based on the decision matrix values. Creates Decision Matrix definitions for the org. Creates Participant roles for access levels on Application Form Product, Application Form, and Party Profile entities. Creates an Autolaunched Flow to invoke the CDSUtil Apex file.
</details>

3. Run `sf apex run --file apex/StageManagement.apex -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Adds rows to the Decision Matrices: AFPStage_To_AFStage, AFPStage_To_ApplicantVisibleStatus, AFPStage_To_CDS_Access
</details>

4. Run `sf project deploy start --metadata-dir metadata/StageDefinition -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates the Stage Definition for Digital Lending  

Note: If the above command fails with error `In field: RunAsUser - no User named 005SG0000070iEkYAI found`, please replace the username mentioned in runAsUser tags with the username of the User deploying the Stage Definition or with the username of the Admin in target org
</details>