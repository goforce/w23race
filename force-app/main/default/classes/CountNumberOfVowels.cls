public without sharing class CountNumberOfVowels {

    @InvocableMethod( label = 'Count Number Of Vowels' )
    public static List<Integer> countNumberOfVowels( List<A__c> la ) {
        List<Integer> results = new List<Integer>();
        for ( A__c a : la ) {
            Integer counter = 0;
            if ( a.Name.contains( 'A') ) counter++;
            if ( a.Name.contains( 'E') ) counter++;
            if ( a.Name.contains( 'I') ) counter++;
            if ( a.Name.contains( 'O') ) counter++;
            if ( a.Name.contains( 'U') ) counter++;
            results.add( counter );
        }
        return results;
    }

}
