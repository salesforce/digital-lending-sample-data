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
 * This apex code will assign permission sets to the user.
 * Usage:
 * Execute this script before any other scripts
 * From project root dir: sf apex run --file apex/OrgSetup.apex -o YourOrgAlias
 */ 

String PREFIX = 'Sample';

PermissionSet dlps = [SELECT Fields(Standard) FROM PermissionSet WHERE Name = 'DigitalLending'].clone();
dlps.Id = null;
dlps.Name = PREFIX + 'DigitalLendingClone';
dlps.Label = PREFIX + ' Financial Services Cloud Digital Lending Clone';
dlps.PermissionsDigitalLendingAdminUser = true;
insert dlps;

PermissionSet cdsps = [SELECT Fields(Standard) FROM PermissionSet WHERE Name = 'CompliantDataSharing'].clone();
cdsps.Id = null;
cdsps.Name = PREFIX + 'CompliantDataSharingClone';
cdsps.Label = PREFIX + ' Financial Services Cloud Compliant Data Sharing Clone';
cdsps.PermissionsConfigCompliantDataSharing = true;
cdsps.PermissionsUseCompliantDataSharing = true;
insert cdsps;

String userId = UserInfo.getUserId();
List<String> permissionSetNames = new List<String> {'BREAdvancedDesignerPsl',
                                                    'BREDesigner',
                                                    'BRERuntime',
                                                    'CLMAdminUser',
                                                    'CLMRuntimeUser',
                                                    'CorePricingAdmin',
                                                    'CorePricingDesignTimeUser',
                                                    'CorePricingManager',
                                                    'CorePricingRunTimeUser',
                                                    'DocGenDesigner',
                                                    'DocGenUser',
                                                    'OmniStudioAdmin',
                                                    'OmniStudioExecution',
                                                    'OmniStudioUser',
                                                    'ProductCatalogManagementAdministrator',
                                                    'ProductCatalogManagementViewer',
                                                    'ProductDiscoveryAdmin', 
                                                    'ProductDiscoveryUser',
                                                    'SampleCompliantDataSharingClone',
                                                    'SampleDigitalLendingClone'};

List<PermissionSetAssignment> assignedPermissions = [SELECT PermissionSet.Name 
                                                     FROM PermissionSetAssignment 
                                                     WHERE AssigneeId =: userId 
                                                     	AND IsActive = true 
                                                     	AND PermissionSet.Name IN :permissionSetNames];
Set<String> assignedPermissionNames = new Set<String>();
for (PermissionSetAssignment assignedPermission: assignedPermissions) {
    assignedPermissionNames.add(assignedPermission.PermissionSet.Name);
}

List<PermissionSet> permissionSets = [SELECT Id, Name
                                      FROM PermissionSet
                                      WHERE Name IN :permissionSetNames];
Map<String, String> permissionSetNameToId = new Map<String, String>();
for (PermissionSet permissionSet: permissionSets) {
    permissionSetNameToId.put(permissionSet.Name, permissionSet.Id);
}

List<PermissionSetAssignment> newPermissionSetAssignments = new List<PermissionSetAssignment>();
for (String permissionName: permissionSetNames) {
    if (!assignedPermissionNames.contains(permissionName)) {
        newPermissionSetAssignments.add(new PermissionSetAssignment(AssigneeId = userId,
                                                                    PermissionSetId = permissionSetNameToId.get(permissionName)));
    }
}

insert newPermissionSetAssignments;

System.debug('Added ' + newPermissionSetAssignments.size() + ' permission sets to the user');

