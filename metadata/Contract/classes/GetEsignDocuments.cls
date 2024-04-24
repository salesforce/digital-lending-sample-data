global class GetEsignDocuments implements ind_docgen_api.OpenInterface {
    private static final String ERROR_UNSUPPORTED = 'Unsupported method. Only method [getDocuments] is supported.';

    public Boolean invokeMethod(String methodName, Map<String, Object> request, Map<String, Object> outMap) {
        Boolean success = true;
        if (methodName == 'getDocuments') {
            success = executeAction(request, outMap);
        } else {
             throw new CustomGetDocumentsException(ERROR_UNSUPPORTED);
         }
        return success;
    }

    private Boolean executeAction(Map<String, Object> inputMap, Map<String, Object> outMap) {
        Boolean success = false;
        System.debug('getDocuments:inputMap -> ' + inputMap);
        Id contractId = (Id)inputMap.get('sourceObjectId');
        
        // Fetch contract master document
        ContentDocument contentDocument = getMasterContractDocument(contractId);
        
        List<Map<String, Object>> documents = new List<Map<String, Object>>();
        Map<String, Object> document = new Map<String, Object>();
        document.put('fileExtension', contentDocument.FileExtension);
        document.put('name',contentDocument.Title);
        String contentVersionId = Id.valueOf(contentDocument.LatestPublishedVersionId);
        document.put('sourceId', contentVersionId);
        document.put('sourceType','Content');
        Map<String, String> additionalFields = new Map<String, String>();
        additionalFields.put('documentId', '1');
        document.put('additionalFields', additionalFields);
        documents.add(document);
        outMap.put('documents', documents);

        success = true;
        System.debug('getDocuments:outMap -> ' + outMap);
        System.debug('getDocuments:success -> ' + success);
        return success;
    }
    
    private ContentDocument getMasterContractDocument(Id contractId) {
        // Fetch latest contract document version
        ContractDocumentVersion latestCdv = [SELECT Id FROM ContractDocumentVersion WHERE contractId=:contractId ORDER BY VersionNumber DESC LIMIT 1];
        
        // Fetch latest contendocumentId associated with latest contract document version
        ContractDocVerContentDoc contractDoc = [SELECT ContentDocumentId FROM ContractDocVerContentDoc WHERE ContractDocumentVersionId=:latestCdv.Id LIMIT 1];
        
        // Load content document details
        ContentDocument contentDocument = [SELECT FileExtension, FileType, Id, LatestPublishedVersionId, Title FROM ContentDocument WHERE Id=:contractDoc.ContentDocumentId LIMIT 1];
        return contentDocument;    
    }

    class CustomGetDocumentsException extends Exception {

    }
}