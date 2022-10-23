trigger A_After_Trigger_Complex on A__c ( after insert, after update ) {
    if ( SkipMe.skipMe ) return;
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
    List<A__c> a2update = new List<A__c>();
    for ( A__c a : Trigger.new ) {
        a2update.add( new A__c( Id = a.Id, Number_Of_Vowels__c = counters.get( a.Id ) ) );
    }
    SkipMe.skipMe = true;
    update a2update;
    SkipMe.skipMe = false;
}