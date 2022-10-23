trigger A_Before_Trigger_Complex on A__c ( before insert, before update ) {
    List<ID> aIds = new List<ID>();
    for ( A__c a : Trigger.new ) {
        aIds.add( a.Id );
    }
    Map<ID,Integer> counters = new Map<ID,Integer>();
    for ( B__c b : [select Id, A__c, Name from B__c where A__c in :aIds] ) {
        Integer counter = counters.get( b.A__c );
        if ( counter == null ) counter = 0;
        if ( b.Name.contains( 'A') ) counter++;
        if ( b.Name.contains( 'E') ) counter++;
        if ( b.Name.contains( 'I') ) counter++;
        if ( b.Name.contains( 'O') ) counter++;
        if ( b.Name.contains( 'U') ) counter++;
        counters.put( b.A__c, counter );
    }
    for ( A__c a : Trigger.new ) {
        a.Number_Of_Vowels__c = counters.get( a.Id );
    }
}