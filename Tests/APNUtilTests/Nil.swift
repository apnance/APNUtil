//
//  Nil.swift
//  
//
//  Created by Aaron Nance on 12/27/22.
//

import XCTest
import APNUtil

final class NilTests: XCTestCase {

    func testNeither() {
        
        let nonNilOpt1: String? = "non-NilOpt1"
        let nonNilOpt2: String? = "non-NilOpt2"
        
        let nilOpt1: String?    = nil
        let nilOpt2: String?    = nil
        
        let nonOpt1             = "non-Opt1"
        let nonOpt2             = "non-Opt2"
        
        // non-nil-opt, self
        XCTAssertFalse(neither(nonNilOpt1, nor: nonNilOpt1))
        
        // non-nil-opt, non-nil-opt
        XCTAssertFalse(neither(nonNilOpt1, nor: nonNilOpt2))
        XCTAssertFalse(neither(nonNilOpt2, nor: nonNilOpt1))
        
        // non-nil-opt, nil-opt
        XCTAssertFalse(neither(nonNilOpt1, nor: nilOpt1))
        XCTAssertFalse(neither(nilOpt1, nor: nonNilOpt1))
        
        // non-nil-opt, nil
        XCTAssertFalse(neither(nonNilOpt1, nor: nil))
        XCTAssertFalse(neither(nil, nor: nonNilOpt1))
        
        // nil-opt, nil-opt
        XCTAssert(neither(nilOpt1, nor: nilOpt2))
        XCTAssert(neither(nilOpt2, nor: nilOpt1))
        
        // nil-opt, nil
        XCTAssert(neither(nilOpt2, nor: nil))
        XCTAssert(neither(nil, nor: nilOpt2))
        
        // non-nil-opt, non-opt
        XCTAssertFalse(neither(nonNilOpt1, nor: nonOpt1))
        XCTAssertFalse(neither(nonOpt1, nor: nonNilOpt1))
        
        // non-opt, non-opt
        XCTAssertFalse(neither(nonOpt1, nor: nonOpt2))
        XCTAssertFalse(neither(nonOpt2, nor: nonOpt1))
        
        // non-opt, nil-opt
        XCTAssertFalse(neither(nonOpt1, nor: nilOpt1))
        XCTAssertFalse(neither(nilOpt1, nor: nonOpt1))
        
        // non-opt, nil
        XCTAssertFalse(neither(nonOpt1, nor: nil))
        XCTAssertFalse(neither(nil, nor: nonOpt1))
        
    }
    
    func testEither() {
                
        let nonNilOpt1: String? = "non-NilOpt1"
        let nonNilOpt2: String? = "non-NilOpt2"
        
        let nilOpt1: String?    = nil
        let nilOpt2: String?    = nil
        
        let nonOpt1             = "non-Opt1"
        let nonOpt2             = "non-Opt2"
        
        // non-nil-opt, self
        XCTAssertFalse(either(nonNilOpt1, or: nonNilOpt1))
        
        // non-nil-opt, non-nil-opt
        XCTAssertFalse(either(nonNilOpt1, or: nonNilOpt2))
        XCTAssertFalse(either(nonNilOpt2, or: nonNilOpt1))
        
        // non-nil-opt, nil-opt
        XCTAssert(either(nonNilOpt1, or: nilOpt1))
        XCTAssert(either(nilOpt1, or: nonNilOpt1))
        
        // non-nil-opt, nil
        XCTAssert(either(nonNilOpt1, or: nil))
        XCTAssert(either(nil, or: nonNilOpt1))
        
        // nil-opt, nil-opt
        XCTAssertFalse(either(nilOpt1, or: nilOpt2))
        XCTAssertFalse(either(nilOpt2, or: nilOpt1))
        
        // nil-opt, nil
        XCTAssertFalse(either(nilOpt2, or: nil))
        XCTAssertFalse(either(nil, or: nilOpt2))
        
        // non-nil-opt, non-opt
        XCTAssertFalse(either(nonNilOpt1, or: nonOpt1))
        XCTAssertFalse(either(nonOpt1, or: nonNilOpt1))
        
        // non-opt, non-opt
        XCTAssertFalse(either(nonOpt1, or: nonOpt2))
        XCTAssertFalse(either(nonOpt2, or: nonOpt1))
        
        // non-opt, nil-opt
        XCTAssert(either(nonOpt1, or: nilOpt1))
        XCTAssert(either(nilOpt1, or: nonOpt1))
        
        // non-opt, nil
        XCTAssert(either(nonOpt1, or: nil))
        XCTAssert(either(nil, or: nonOpt1))
        
    }

}
