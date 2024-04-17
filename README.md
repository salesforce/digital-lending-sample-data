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

1. `sf apex run --file apex/OrgSetup.apex -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates a custom permission set SampleDigitalLendingClone. 

Assigns this and several other permission sets to the user.
</details>

2. `sf project deploy start --metadata-dir metadata/OrgSetup -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates a custom profile: Sample Customer Community Plus Login User Clone.

Creates a custom field City on ProductQualification object. 

Assigns fieldpermissions to Admin and Sample Customer Community Plus Login User Clone profiles for the new field.

Enables Context Definition in the org.
</details>

3. Navigate to `Product Discovery Settings` from Setup (`Feature Settings` &rarr; `Product Discovery` &rarr; `Product Discovery Settings`), and enable `Qualification Procedure`.

4. Navigate to `Digital Lending` from Setup (`Feature Settings` &rarr; `Lending` &rarr; `Digital Lending`), and enable `Digital Lending`.

In the above steps, a new custom field `City__c` has been created on `ProductQualification` object. We also assigned field permissions for two profiles. Assign field permissions to any other profiles you want this field to be visible from Setup.

### Product Configuration

1. `sf apex run --file apex/ProductConfiguration.apex -o YourOrgAlias`
<details>
<summary>Command Details</summary>
[TODO] Details about product config

Creates a product qualification records.
</details>

### Product Qualification

1. `sf project deploy start --metadata-dir metadata/ProductQualificationSetup -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates a Decision Table for Product Qualification.
</details>

2. `sf project deploy start --metadata-dir metadata/ProductQualificationExpressionSet -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates two expression sets for Product Qualification.
</details>

### Disclosure And Consent

1. `sf project deploy start --metadata-dir metadata/DisclosureAndConsent -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates a Decision Matrix for Disclosure And Consent.
</details>

2. `sf apex run --file apex/DisclosureAndConsent.apex -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates Application Form, Application Form Text, Data Use Purpose, and ApplicationFormDataUse record.

Adds rows to the Decision Matrix for Disclosure And Consent.
</details>

### Document Upload

1. `sf project deploy start --metadata-dir metadata/DocumentUpload -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates a Decision Matrix for Document Upload.

Creates two Document Types.
</details>

2. `sf apex run --file apex/DocumentUpload.apex -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Adds rows to the Decision Matrix for Document Upload.
</details>

### Straight Through Processing

1. `sf project deploy start --metadata-dir metadata/StraightThroughProcessing -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates a Decision Matrix for Straight Through Processing.
</details>

2. `sf apex run --file apex/StraightThroughProcessing.apex -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Adds rows to the Decision Matrix for Straight Through Processing.

Activates Decision Matrix for Straight Through Processing.
</details>
