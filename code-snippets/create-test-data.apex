List<String> abc = new List<String>{
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'
  , 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T'
  , 'U', 'V', 'W', 'X', 'Y', 'Z'
};
List<A__c> la = new List<A__c>();
List<B__c> lb = new List<B__c>();
for ( Integer i = 0; i < 20; i++ ) {
    for ( Integer j = 0; j < 10; j++ ) {
        for ( Integer k = 0; k < 10; k++ ) {
            String n = abc[i] + abc[j] + abc[k];
            la.add( new A__c( Name = n ) );
            for ( Integer l = 0; l < 2; l++ ) {
                lb.add( new B__c( Name = n ) );
            }
        }
    }
}
insert la;
insert lb;