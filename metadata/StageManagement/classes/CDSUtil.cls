public with sharing class CDSUtil {

private static final String DM_APP_FORM_PRODUCT_STAGE_FIELD_NAME = 'ApplicationFormProductStage';
private static final String DM_APP_FORM_STAGE_FIELD_NAME = 'ApplicationFormStage';
private static final String DM_APPLICANT_STATUS_FIELD_NAME = 'ApplicantVisibleStatus';

private static final String DM_AFP_STAGE_TO_AF_STAGE = 'AFPStage_To_AFStage';
private static final String DM_AFP_STAGE_TO_APPLICANT_STATUS = 'AFPStage_To_ApplicantVisibleStatus';
private static final String DM_AFP_STAGE_TO_CDS_ACCESS = 'AFPStage_To_CDSAccess';

private static final String DM_UW_ACCESS_FIELD_NAME = 'Underwriter_Access';
private static final String DM_APPLICANT_AGENT_ACCESS_FIELD_NAME = 'Applicant_Agent_Access';

private static final String APPLICATION_FORM = 'ApplicationForm';
private static final String APPLICATION_FORM_PRODUCT = 'ApplicationFormProduct';
private static final String PARTY_PROFILE = 'PartyProfile';

private static final String UNDERWRITER_PARTICIPANT_GROUP_NAME = 'Underwriter_Group';
private static final String AGENT_PARTICIPANT_GROUP_NAME = 'Agent_Group';
private static final String CDS_PERMISSION_SET_NAME = 'CompliantDataSharing_User';
    
static {
    CDSCacheHelper.loadCDSData();
}

@InvocableMethod(label = 'Digital Lending CDS'
    description = 'Creates the CDS records on ApplicationForm/ApplicationFormProduct/PartyProfile based on the configuration.')
public static List <Result> execute(List <ID> ids) {
    List <Result> results = new List <Result> ();
    Result result = new Result();
    try {

        Id applicationFormProductId = ids.get(0);

        ApplicationFormProduct appFormProduct = [SELECT Id, Stage, ApplicantVisibleStatus, ApplicationFormId FROM ApplicationFormProduct WHERE Id =: applicationFormProductId];

        updateApplicantVisibleStatus(appFormProduct);
        updateApplicationFormStage(appFormProduct);

        Invocable.Action.Result cdsDmResult = invokeDecisionMatrix(DM_AFP_STAGE_TO_CDS_ACCESS, appFormProduct.Stage);
        String applicantAgentRole = getOutputVal(cdsDmResult, DM_APPLICANT_AGENT_ACCESS_FIELD_NAME);
        String underwriterRole = getOutputVal(cdsDmResult, DM_UW_ACCESS_FIELD_NAME);

        String[] applicantAgentRoles = applicantAgentRole.split(',');
        String[] underwriterRoles = underwriterRole.split(',');

        Set <Id> partyProfileIds = new Set < Id > ();

        List <Applicant> applicants = [SELECT Id, Email, ApplicationFormId, PartyProfileId FROM Applicant WHERE ApplicationFormId =: appFormProduct.ApplicationFormId];

        for (Applicant applicant: applicants) {
            if (applicant.PartyProfileId != null) {
                partyProfileIds.add(applicant.PartyProfileId);
            }
            // If no users where email matches applicant email, continue
            List<User> users = [SELECT Id FROM USER WHERE Email =: applicant.Email];
            if (users.size() == 0) {
                continue;
            }
            User user = users.get(0);

            // If user does not have CDS permission, continue
            List<PermissionSetAssignment> permissionSetAssignments = [SELECT AssigneeId, PermissionSet.Name FROM PermissionSetAssignment 
                                                                       WHERE AssigneeId =: user.Id AND PermissionSet.Name =: CDS_PERMISSION_SET_NAME ];
            if (permissionSetAssignments.size() == 0) {
                continue;
            }

            for (String cdsRole: applicantAgentRoles) {
                if (cdsRole.startsWith(APPLICATION_FORM_PRODUCT)) {
                    handleApplicationFormProductParticipants(user.Id, appFormProduct, cdsRole);
                } else if (cdsRole.startsWith(APPLICATION_FORM)) {
                    handleApplicationFormParticipants(user.Id, appFormProduct, cdsRole);
                } else if (cdsRole.startsWith(PARTY_PROFILE)) {
                    handlePartyProfileParticipants(user.Id, applicant.PartyProfileId, cdsRole);
                }
            }
        }
        // Updating / Creating Participant Records for Underwrite groups 
        handleCDSUpdatesForGroups(UNDERWRITER_PARTICIPANT_GROUP_NAME, underwriterRoles, partyProfileIds, appFormProduct);

        // Updating / Creating Participant Records for Agent groups 
        handleCDSUpdatesForGroups(AGENT_PARTICIPANT_GROUP_NAME, applicantAgentRoles, partyProfileIds, appFormProduct);
        result.isSuccess = true;
        result.message = 'Stage configuration executed successfully.';

    } catch (Exception ex) {
        result.isSuccess = false;
        result.message = ex.getMessage();
        System.debug(ex);
    }

    results.add(result);
    return results;
}

public static void handleCDSUpdatesForGroups(String groupName, String[] roles, Set < Id > partyProfileIds, ApplicationFormProduct appFormProduct) {
    String groupId = CDSCacheHelper.PARTICIPANT_GROUP_NAME_TO_ID.get(groupName);
    for (String cdsRole: roles) {
        if (cdsRole.startsWith(APPLICATION_FORM_PRODUCT)) {
            handleApplicationFormProductParticipants(groupId, appFormProduct, cdsRole);
        } else if (cdsRole.startsWith(APPLICATION_FORM)) {
            handleApplicationFormParticipants(groupId, appFormProduct, cdsRole);
        } else if (cdsRole.startsWith(PARTY_PROFILE)) {
            for (Id partyProfileId: partyProfileIds) {
                handlePartyProfileParticipants(groupId, partyProfileId, cdsRole);
            }
        }
    }
}

public static void updateApplicantVisibleStatus(ApplicationFormProduct appFormProduct) {
    Invocable.Action.Result result = invokeDecisionMatrix(DM_AFP_STAGE_TO_APPLICANT_STATUS, appFormProduct.Stage);
    String applicantVisibleStatus = getOutputVal(result, DM_APPLICANT_STATUS_FIELD_NAME);
    appFormProduct.ApplicantVisibleStatus = applicantVisibleStatus;
    upsert appFormProduct;
}

public static void updateApplicationFormStage(ApplicationFormProduct appFormProduct) {
    Invocable.Action.Result result = invokeDecisionMatrix(DM_AFP_STAGE_TO_AF_STAGE, appFormProduct.Stage);
    String applicationFormStage = getOutputVal(result, DM_APP_FORM_STAGE_FIELD_NAME);
    
    ApplicationForm applicationForm = new ApplicationForm();
    applicationForm.Id = appFormProduct.ApplicationFormId;
    applicationForm.Stage = applicationFormStage;
    upsert applicationForm;
}

public static void handleApplicationFormParticipants(Id userOrGroupId, ApplicationFormProduct appFormProduct, String roleName) {
    List<ApplicationFormParticipant> appFormParticipants = [SELECT Id, ParticipantRoleId FROM ApplicationFormParticipant WHERE ParticipantId =: userOrGroupId AND ApplicationFormId=:appFormProduct.ApplicationFormId];
    String roleId = CDSCacheHelper.PARTICIPANT_ROLE_NAME_TO_ID.get(roleName);
    if (appFormParticipants.size() == 0) {
        ApplicationFormParticipant participant = new ApplicationFormParticipant(ApplicationFormId = appFormProduct.ApplicationFormId,
                                                                                IsActive = true,
                                                                                ParticipantRoleId = roleId,
                                                                                ParticipantId=userOrGroupId);
        insert participant;
    } else {
        ApplicationFormParticipant participant = appFormParticipants.get(0);
        participant.IsActive = true;
        participant.ParticipantRoleId = roleId;
        upsert participant;
    }
}

public static void handleApplicationFormProductParticipants(Id userOrGroupId, ApplicationFormProduct appFormProduct, String roleName) {
    List<AppFormProductParticipant> participants = [SELECT Id, ParticipantRoleId FROM AppFormProductParticipant WHERE ParticipantId =: userOrGroupId AND ApplicationFormProductId=:appFormProduct.Id];
    String roleId = CDSCacheHelper.PARTICIPANT_ROLE_NAME_TO_ID.get(roleName);
    if (participants.size() == 0) {
        AppFormProductParticipant participant = new AppFormProductParticipant(ApplicationFormProductId = appFormProduct.Id,
                                                                              IsActive = true,
                                                                              ParticipantRoleId = roleId,
                                                                              ParticipantId=userOrGroupId);
        insert participant;
    } else {
        AppFormProductParticipant participant = participants.get(0);
        participant.IsActive = true;
        participant.ParticipantRoleId = roleId;
        upsert participant;
    }
}

public static void handlePartyProfileParticipants(Id userOrGroupId, String partyProfileId, String roleName) {
    List<PartyProfileParticipant> participants = [SELECT Id, ParticipantRoleId FROM PartyProfileParticipant WHERE ParticipantId =: userOrGroupId AND PartyProfileId=:partyProfileId];
    String roleId = CDSCacheHelper.PARTICIPANT_ROLE_NAME_TO_ID.get(roleName);
    if (participants.size() == 0) {
        PartyProfileParticipant participant = new PartyProfileParticipant(PartyProfileId = partyProfileId,
                                                                          IsActive = true,
                                                                          ParticipantRoleId = roleId,
                                                                          ParticipantId=userOrGroupId);
        insert participant;
    } else {
        PartyProfileParticipant participant = participants.get(0);
        participant.IsActive = true;
        participant.ParticipantRoleId = roleId;
        upsert participant;
    }
}


public static Invocable.Action.Result invokeDecisionMatrix(String decisionMatrixName, String appFormProductStageVal) {
    // Create an Invocable.Action
    Invocable.Action action = Invocable.Action.createCustomAction('runDecisionMatrix', decisionMatrixName);
    action.setInvocationParameter(DM_APP_FORM_PRODUCT_STAGE_FIELD_NAME, appFormProductStageVal);
    List < Invocable.Action.Result > results = action.invoke();
    return results.get(0);
}

public static String getOutputVal(Invocable.Action.Result result, String outputFieldName) {
    return (String) result.getOutputParameters().get(outputFieldName);
}


public class Result {
    @InvocableVariable(label = 'Message'
                       description = 'Resulted output of the action.'
                       required = true)
    public String message;
    
    @InvocableVariable(label = 'Status'
                       description = 'Resulted status of the action.'
                       required = true)
    public boolean isSuccess;
}
}