delete [SELECT Id FROM ProductClassificationAttr];

delete [SELECT Id FROM Product2];

delete [SELECT Id FROM ProductClassification];

delete [SELECT Id FROM AttributeDefinition];

delete [SELECT Id FROM AttributePicklistValue];

delete [SELECT Id FROM AttributePicklist];

delete [SELECT Id FROM ProductCategoryProduct];

delete [SELECT Id FROM ProductCategory];

delete [SELECT Id FROM ProductCatalog];

List<DataUsePurpose> dups = [SELECT Id FROM DataUsePurpose];
for (DataUsePurpose dup : dups) {
    dup.IsActive = false;
}
update dups;

delete [SELECT Id FROM AuthorizationFormDataUse];

delete [SELECT Id FROM AuthorizationFormText];

delete [SELECT Id FROM AuthorizationForm];

delete [SELECT Id FROM DataUsePurpose];

List<CalculationMatrixVersion> versions = [SELECT Id FROM CalculationMatrixVersion];
for (CalculationMatrixVersion version : versions) {
    version.IsEnabled = false;
}
update versions;
delete [SELECT Id FROM CalculationMatrixRow];
