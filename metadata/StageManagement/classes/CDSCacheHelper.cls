public class CDSCacheHelper {

    public static Map<String, String> PARTICIPANT_ROLE_NAME_TO_ID = new Map<String, String>();
    public static Map<String, String> PARTICIPANT_GROUP_NAME_TO_ID = new Map<String, String>();
    
    public static void loadCDSData() {
	
        if (!(PARTICIPANT_ROLE_NAME_TO_ID.isEmpty() || PARTICIPANT_GROUP_NAME_TO_ID.isEmpty())) {
            return;
        }        
        
        // Caching participant roles
        List<Participantrole> paticipantRoles = [SELECT ID, DeveloperName FROM ParticipantRole WHERE IsActive = true];
        for (Participantrole role: paticipantRoles) {
            PARTICIPANT_ROLE_NAME_TO_ID.put(role.DeveloperName, role.ID);
        }
        
        // Caching participant groups
        List<Group> groups = [SELECT ID, DeveloperName FROM Group WHERE Type = 'Participant'];
        for (Group groupData: groups) {
            PARTICIPANT_GROUP_NAME_TO_ID.put(groupData.DeveloperName, groupData.ID);
        }
        
    }
    
}