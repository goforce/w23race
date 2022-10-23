trigger A_After_Trigger_Simple on A__c ( after insert, after update ) {

    if ( SkipMe.skipMe ) return;

    List<A__c> a2update = new List<A__c>();
    for ( A__c a : Trigger.new ) {
        Integer counter = 0;
        if ( a.Name.contains( 'A') ) counter++;
        if ( a.Name.contains( 'E') ) counter++;
        if ( a.Name.contains( 'I') ) counter++;
        if ( a.Name.contains( 'O') ) counter++;
        if ( a.Name.contains( 'U') ) counter++;
        a2update.add( new A__c( Id = a.Id, Number_Of_Vowels__c = counter ) );
    }

    SkipMe.skipMe = true;
    update a2update;
    SkipMe.skipMe = false;

}