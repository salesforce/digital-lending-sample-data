global class RLMDocumentTemplateFilter implements industries_clm.OpenInterface {
    public Boolean invokeMethod(String methodName, Map<String, Object> request, Map<String, Object> outMap) {
        system.debug(request);
        List<DocumentTemplate> dTList = [SELECT Id, IsActive, Name, Type, VersionNumber from DocumentTemplate WHERE IsActive = true AND UsageType = 'Revenue_Lifecycle_Management' AND Type = 'MicrosoftWord' LIMIT 10];
        system.debug(dTList);
        outMap.put('documentTemplateList', dtList);
        return true;
    }
}