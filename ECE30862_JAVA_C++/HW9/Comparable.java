interface Comparable{
    // The Comparable interface goes here.
    double value( );
//This method returns the value of a Comparable object as a double precision floating point number.
    boolean lessThan(Comparable c);
//This method compares what is returned by this.value( ) and c.value( ), and returns true is this.value < c.value( ), and false otherwise.
    boolean equal(Comparable c);
//This method compares what is returned by this.value( ) and c.value( ), and returns true is this.value == c.value( ), and false otherwise.
    boolean greaterThan(Comparable c);
//This method compares what is returned by this.value( ) and c.value( ), and returns true is this.value > c.value( ), and false otherwise.

}