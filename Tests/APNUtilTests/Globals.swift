
/// Global test func for cchecking string results for equivalence then finding first difference if not equal.
func check(_ exp: String, _ act: String) {
    
    XCTAssert(exp == act,
              """
                
                -----
                Expected:
                \(exp)
                - - - 
                Actual:
                \(act)
                - - -
                Diff:
                \(exp.diff(with: act))
                -----
                """)
}
