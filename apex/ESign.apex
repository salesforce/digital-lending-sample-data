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
 * This apex code creates Object State Transition for ESign
 * Usage:
 * From project root dir: sf apex run --file apex/ESign.apex -o YourOrgAlias
 */

//Set objectStateDefinition status to not active
List<ObjectStateDefinition> objectStateDefinitions = [SELECT Id, IsActive FROM ObjectStateDefinition WHERE Name = 'Contract LifeCycle Management'];
objectStateDefinitions.get(0).IsActive = false;
update objectStateDefinitions;


List<ObjectStateValue> objectStateValueDraft = [SELECT Id, Name FROM ObjectStateValue WHERE Name = 'Draft'];
List<ObjectStateValue> objectStateValueAwaitingSignature = [SELECT Id, Name FROM ObjectStateValue WHERE Name = 'Awaiting Signature'];

// Insert objectStateTransition
List<ObjectStateTransition> objectStateTransitions = new List<ObjectStateTransition>();
objectStateTransitions.add(new ObjectStateTransition(Name = 'Draft_To_AwaitingSignature',
                                ObjectStateDefinitionId = objectStateDefinitions.get(0).Id,
                                FromStateId = objectStateValueDraft.get(0).Id,
                                ToStateId = objectStateValueAwaitingSignature.get(0).Id));
insert objectStateTransitions;

//Set objectStateDefinition status to active
objectStateDefinitions.get(0).IsActive = true;
update objectStateDefinitions;
