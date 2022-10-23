trigger A_Before_Trigger_Simple on A__c ( before insert, before update ) {
    for ( A__c a : Trigger.new ) {
        Integer counter = 0;
        if ( a.Name.contains( 'A') ) counter++;
        if ( a.Name.contains( 'E') ) counter++;
        if ( a.Name.contains( 'I') ) counter++;
        if ( a.Name.contains( 'O') ) counter++;
        if ( a.Name.contains( 'U') ) counter++;
        a.Number_Of_Vowels__c = counter;
    }
}