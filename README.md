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
Creates two custom permission sets: SampleDigitalLendingClone and SampleCompliantDataSharingClone. 

Assigns these and several other permission sets to the user.
</details>

2. `sf project deploy start --metadata-dir metadata/OrgSetup -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates a custom profile: Sample Customer Community Plus Login User Clone.

Enables Context Definition in the org.
</details>

3. Navigate to `Product Discovery Settings` from Setup, and enable `Qualification Procedure`.

### Product Configuration

TODO

### Product Qualification

1. Replace `REPLACME`s in `apex/ProductQualification.apex` with Auto Loan and Personal Loan productId obtained from [Product Configuration](#product-configuration) section.

2. `sf project deploy start --metadata-dir metadata/ProductQualificationSetup -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates a custom field City on ProductQualification object. 

Assign fieldpermissions to Admin and Sample Customer Community Plus Login User Clone profiles for the new field.

Create a Decision Table for Product Qualification.
</details>

3. `sf apex run --file apex/ProductQualification.apex -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Creates two product qualification records, one for auto loan, and another for personal loan.
</details>

4. `sf project deploy start --metadata-dir metadata/ProductQualificationExpressionSet -o YourOrgAlias`
<details>
<summary>Command Details</summary>
Create two expression sets for Product Qualification.
</details>

In the above steps, a new custom field `City__c` has been created on `ProductQualification` object. We also assigned field permissions for two profiles. Assign field permissions to any other profiles you want this field to be visible from Setup.