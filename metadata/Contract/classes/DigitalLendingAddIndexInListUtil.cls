public class DigitalLendingAddIndexInListUtil implements Callable {

    public object call(String action, Map<String, Object> args) {

        Map<String, Object> input = (Map<String, Object>) args.get('input');
        Map<String, Object> output = (Map<String, Object>) args.get('output');
        Map<String, Object> options = (Map<String, Object>) args.get('options');
        return invokeMethod(action, input, output, options);
    }

    public boolean invokeMethod(String methodName, Map<String, Object> input, Map<String, Object> output, Map<String, Object> options) {
        try {
            if ('populateIndex'.equals(methodName)) {
                List<Object> argList = (List<Object>)input.get('arguments');
                for (Integer i=0; i < argList.size(); i++) {
                    Map<String, Object> objectMap = (Map<String, Object>)argList[i];
                    objectMap.put('Index', i+1);
                }
                output.put('result', argList);
            }
        } catch(Exception ex) {
            System.debug('DigitalLendingAddIndexInListUtil '+ex);
            return false;
        }
        return true;
    }
}