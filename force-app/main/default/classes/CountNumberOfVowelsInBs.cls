public without sharing class CountNumberOfVowelsInBs {

    @InvocableMethod( label = 'Count Number Of Vowels In Bs' )
    public static List<Integer> countNumberOfVowels( List<List<B__c>> llb ) {
        List<Integer> results = new List<Integer>();
        for ( List<B__c> lb : llb ) {
            Integer counter = 0;
            for ( B__c b : lb ) {
                if ( b.Name.contains( 'A') ) counter++;
                if ( b.Name.contains( 'E') ) counter++;
                if ( b.Name.contains( 'I') ) counter++;
                if ( b.Name.contains( 'O') ) counter++;
                if ( b.Name.contains( 'U') ) counter++;
            }
            results.add( counter );
        }
        return results;
    }

}
