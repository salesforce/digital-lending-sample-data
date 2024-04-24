public class GetEsignRecipients implements ind_docgen_api.OpenInterface {

    private static final String ERROR_UNSUPPORTED = 'Unsupported method. Only method [getRecipients] is supported.';
    private static final String ERROR_NO_RECIPIENTS = 'Recipient data not found';

    public Boolean invokeMethod(String methodName, Map<String, Object> inputMap, Map<String, Object> outMap) {
        system.debug(inputMap);
        Boolean success;

        if (methodName == 'getRecipients') {
            success = getRecipients(inputMap, outMap);
        }  else {
            throw new CustomGetRecipientsException(ERROR_UNSUPPORTED);
        }

        System.debug('invokeMethod:outMap -> ' + outMap);
        System.debug('invokeMethod:success -> ' + success);
        return success;
    }

    private Boolean getRecipients(Map<String, Object> input, Map<String, Object> output) {
        Boolean success = false;

        Id sourceObjectId = (Id) input.get('sourceObjectId');
        
        Applicant[] applicants = getApplicants(sourceObjectId);
        
        if (applicants.size() == 0) {
            throw new CustomGetRecipientsException(ERROR_NO_RECIPIENTS);
        }
        
        //follows recipient list object structured here: https://developer.salesforce.com/docs/atlas.en-us.clm_developer_guide.meta/clm_developer_guide/connect_responses_recipient_list_respons.htm
        List<Map<String, Object>> recipients = new List<Map<String, Object>>();
		
        for(Integer i=0; i<applicants.size(); i++ ) {
           Map<String, Object> recipient = new Map<String, Object>();
            recipient.put('name', applicants[i].FirstName+' '+applicants[i].LastName);
            recipient.put('email', applicants[i].Email);
            String indexAsStr = String.valueOf(i+1);
            recipient.put('id', indexAsStr);
            Map<String, Object> additionalFields = new Map<String, Object>();
            additionalFields.put('routingOrder', indexAsStr);
            additionalFields.put('routingNumber', indexAsStr);
            additionalFields.put('signerRole', indexAsStr);
            additionalFields.put('recipientType','signer');
            additionalFields.put('recipientLocale','EN');
            recipient.put('additionalFields', additionalFields);
            recipients.add(recipient);    
        }        
  	    output.put('recipients', recipients);
        success = true;
        System.debug('getRecipients:output -> ' + output);
        System.debug('getRecipients:success -> ' + success);
        return success;
    }
    
    public Applicant[] getApplicants(Id contractId) {
        // Fetch contract to retrieve applicationFormProductId associated with it
 		Contract contract = [SELECT Id, SourceApplicationFormProduct__c FROM Contract WHERE Id=:contractId LIMIT 1];
        System.debug('contract:'+contract);
        String applicationFormProductId = contract.SourceApplicationFormProduct__c;
        System.debug('ApplicationFormProductId:'+applicationFormProductId);
        // Load application form product
        ApplicationFormProduct appFormProduct = [SELECT Id, ApplicationFormId FROM ApplicationFormProduct WHERE Id=:applicationFormProductId LIMIT 1];
        Applicant[] applicants = [SELECT FirstName, LastName, Email, Role FROM Applicant WHERE ApplicationFormId=:appFormProduct.ApplicationFormId];
        return applicants;
    }

    class CustomGetRecipientsException extends Exception {

    }
}