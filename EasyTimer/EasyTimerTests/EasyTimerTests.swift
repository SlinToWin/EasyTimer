//
//  EasyTimerTests.swift
//  EasyTimerTests
//
//  Created by Niklas Fahl on 3/2/16.
//  Copyright © 2016 High Bay. All rights reserved.
//

import XCTest
@testable import EasyTimer

class EasyTimerTests: XCTestCase {
    
    // MARK: - Setting up helpers to be able to test asynchronous tasks
    var waitingForBlock: Bool = false
    func startBlock() {
        waitingForBlock = true
    }
    
    func endBlock() {
        waitingForBlock = false
    }
    
    func waitUntilBlockCompletes() {
        while waitingForBlock {
            NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 0.1))
        }
    }
    
    // MARK: Set up/Tear Down
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Timer Creation
    func testTimerCreation() {
        let timer = 3.minute.timer(repeats: true, delays: true) {
            // ...
        }
        XCTAssertTrue(timer.valid)
    }
    
    func testTimerCreationPassingTimerInBlock() {
        let timer = 3.minute.timer(repeats: true, delays: true) { (timer: NSTimer) -> Void in
            // ...
        }
        XCTAssertTrue(timer.valid)
    }
    
    // MARK: - Starting/Stopping Timer
    func testStartNotRepeatingNotDelayingTimer() {
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        let timer = 3.second.timer(repeats: false, delays: false) { (timer: NSTimer) -> Void in
            let delayTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            XCTAssertTrue(delayTime == 3)
        }
        timer.start()
    }
    
    func testStartRepeatingNotDelayingTimer() {
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        let timer = 3.second.timer(repeats: true, delays: false) { (timer: NSTimer) -> Void in
            let delayTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            XCTAssertTrue(delayTime == 3)
        }
        timer.start()
    }
    
    func testStartNotRepeatingDelayingTimer() {
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        let timer = 3.second.timer(repeats: false, delays: true) { (timer: NSTimer) -> Void in
            let delayTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            XCTAssertTrue(delayTime == 3)
        }
        timer.start()
    }
    
    func testStartRepeatingDelayingTimer() {
        startBlock()
        
        var startTimeStamp = CFAbsoluteTimeGetCurrent()
        var count = 0
        let timer = 3.second.timer(repeats: true, delays: true) { (timer: NSTimer) -> Void in
            let intervalTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            startTimeStamp = CFAbsoluteTimeGetCurrent()
            count++
            
            if count == 2 {
                self.endBlock()
                let intervalTolerance = abs(3 - intervalTime)
                XCTAssertLessThan(intervalTolerance, 0.01)
            }
        }
        timer.start()
        
        waitUntilBlockCompletes()
    }
    
    func testStoppingTimer() {
        
    }
    
    // MARK: - Delay
    func testDelay() {
        // Test delay of 2 seconds
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        2.second.delay {
            let delayTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            XCTAssertEqual(delayTime, 2)
        }
    }
    
    func testDelayPassingTimerInBlock() {
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        5.second.delay { (timer: NSTimer) -> Void in
            let delayTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            XCTAssertEqual(delayTime, 2)
        }
    }
    
    func testTimerInDelayBlock() {
        5.second.delay { (timer: NSTimer) -> Void in
            XCTAssertTrue(timer.valid)
        }
    }
    
    // MARK: - Interval
    func testInterval() {
        
    }
    
    func testIntervalPassingTimerInBlock() {
        
    }
    
    // MARK: - Delayed Interval
    func testDelayedInterval() {
        
    }
    
    func testDelayedIntervalPassingTimerInBlock() {
        self.measureBlock {
            var startTimeStamp = CFAbsoluteTimeGetCurrent()
            var count = 0
            3.second.delayedInterval { (timer: NSTimer) -> Void in
                let intervalTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
                startTimeStamp = CFAbsoluteTimeGetCurrent()
                count++
                
                if count == 2 {
                    XCTAssertEqual(intervalTime, 3)
                    timer.stop()
                }
            }
        }
    }
}
