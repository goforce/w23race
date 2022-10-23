public with sharing class PerfTestServices {

    public PerfTestServices() {}

    @AuraEnabled(cacheable=false)
    public static Long runUpdate( String soql ) {
        List<SObject> l = Database.query( soql );
        Long s = System.currentTimeMillis();
        update l;
        return System.currentTimeMillis() - s;
    }

}