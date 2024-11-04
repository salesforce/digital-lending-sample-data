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
 * This apex code will create 2 participant groups called Agent_Group and Underwriter_Group
 * From project root dir: sf apex run --file apex/StageManagementGroupSetup.apex -o YourOrgAlias
 */ 

Group agentGroup = new Group();
agentGroup.Name = 'Agent_Group';
agentGroup.Type = 'Participant';
insert agentGroup;

Group underwriterGroup = new Group();
underwriterGroup.Name = 'Underwriter_Group';
underwriterGroup.Type = 'Participant';
insert underwriterGroup;