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
    
    // MARK: - Time Interval
    // Doubles
    func testDoubleMillisecondTimeIntervals() {
        XCTAssertEqual(2.0.millisecond, 0.002)
    }
    
    func testDoubleSecondTimeIntervals() {
        XCTAssertEqual(3.0.second, 3.0)
    }
    
    func testDoubleMinuteTimeIntervals() {
        XCTAssertEqual(4.0.minute, 240.0)
    }
    
    func testDoubleHourTimeIntervals() {
        XCTAssertEqual(5.0.hour, 18000.0)
    }
    
    func testDoubleDayTimeIntervals() {
        XCTAssertEqual(6.0.day, 518400.0)
    }
    
    // Ints
    func testIntMillisecondTimeIntervals() {
        XCTAssertEqual(2.millisecond, 0.002)
    }
    
    func testIntSecondTimeIntervals() {
        XCTAssertEqual(3.second, 3.0)
    }
    
    func testIntMinuteTimeIntervals() {
        XCTAssertEqual(4.minute, 240.0)
    }
    
    func testIntHourTimeIntervals() {
        XCTAssertEqual(5.hour, 18000.0)
    }
    
    func testIntDayTimeIntervals() {
        XCTAssertEqual(6.day, 518400.0)
    }
    
    // MARK: - Starting/Stopping Timer
    func testStartNotRepeatingNotDelayingTimer() {
        let expectation = expectationWithDescription("testStartNotRepeatingNotDelayingTimer")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        let timer = 3.second.timer(repeats: false, delays: false) { 
            let delayTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            let intervalTolerance = abs(0 - delayTime)
            XCTAssertLessThan(intervalTolerance, 0.02)
            expectation.fulfill()
        }
        timer.start()
        
        waitForExpectationsWithTimeout(0.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            timer.stop()
        }
    }
    
    func testStartRepeatingNotDelayingTimer() {
        let expectation = expectationWithDescription("testStartRepeatingNotDelayingTimer")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        var count = 0
        let timer = 3.second.timer(repeats: true, delays: false) {
            let intervalTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            count++
            
            if count == 2 {
                let intervalTolerance = abs(3 - intervalTime)
                XCTAssertLessThan(intervalTolerance, 0.02)
                expectation.fulfill()
            }
        }
        timer.start()
        
        waitForExpectationsWithTimeout(3.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            timer.stop()
        }
    }
    
    func testStartNotRepeatingDelayingTimer() {
        let expectation = expectationWithDescription("testStartNotRepeatingDelayingTimer")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        let timer = 3.second.timer(repeats: false, delays: true) {
            let delayTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            let intervalTolerance = abs(3 - delayTime)
            XCTAssertLessThan(intervalTolerance, 0.02)
            expectation.fulfill()
        }
        timer.start()
        
        waitForExpectationsWithTimeout(3.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            timer.stop()
        }
    }
    
    func testStartRepeatingDelayingTimer() {
        let expectation = expectationWithDescription("testStartRepeatingDelayingTimer")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        var count = 0
        let timer = 3.second.timer(repeats: true, delays: true) {
            let intervalTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            count++
            
            if count == 2 {
                let intervalTolerance = abs(6 - intervalTime)
                XCTAssertLessThan(intervalTolerance, 0.02)
                expectation.fulfill()
            }
        }
        timer.start()
        
        waitForExpectationsWithTimeout(6.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            timer.stop()
        }
    }
    
    func testStartNotRepeatingNotDelayingTimerPassingTimerInBlock() {
        let expectation = expectationWithDescription("testStartNotRepeatingNotDelayingTimerPassingTimerInBlock")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        let timer = 3.second.timer(repeats: false, delays: false) { (timer: NSTimer) -> Void in
            let delayTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            let intervalTolerance = abs(0 - delayTime)
            XCTAssertLessThan(intervalTolerance, 0.02)
            expectation.fulfill()
        }
        timer.start()
        
        waitForExpectationsWithTimeout(0.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            timer.stop()
        }
    }
    
    func testStartRepeatingNotDelayingTimerPassingTimerInBlock() {
        let expectation = expectationWithDescription("testStartRepeatingNotDelayingTimerPassingTimerInBlock")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        var count = 0
        let timer = 3.second.timer(repeats: true, delays: false) { (timer: NSTimer) -> Void in
            let intervalTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            count++
            
            if count == 2 {
                let intervalTolerance = abs(3 - intervalTime)
                XCTAssertLessThan(intervalTolerance, 0.02)
                expectation.fulfill()
            }
        }
        timer.start()
        
        waitForExpectationsWithTimeout(3.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            timer.stop()
        }
    }
    
    func testStartNotRepeatingDelayingTimerPassingTimerInBlock() {
        let expectation = expectationWithDescription("testStartNotRepeatingDelayingTimerPassingTimerInBlock")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        let timer = 3.second.timer(repeats: false, delays: true) { (timer: NSTimer) -> Void in
            let delayTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            let intervalTolerance = abs(3 - delayTime)
            XCTAssertLessThan(intervalTolerance, 0.02)
            expectation.fulfill()
        }
        timer.start()
        
        waitForExpectationsWithTimeout(3.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            timer.stop()
        }
    }
    
    func testStartRepeatingDelayingTimerPassingTimerInBlock() {
        let expectation = expectationWithDescription("testStartRepeatingDelayingTimerPassingTimerInBlock")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        var count = 0
        let timer = 3.second.timer(repeats: true, delays: true) { (timer: NSTimer) -> Void in
            let intervalTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            count++
            
            if count == 2 {
                let intervalTolerance = abs(6 - intervalTime)
                XCTAssertLessThan(intervalTolerance, 0.02)
                expectation.fulfill()
            }
        }
        timer.start()
        
        waitForExpectationsWithTimeout(6.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            timer.stop()
        }
    }
    
    func testStoppingTimer() {
        let timer = 2.second.interval {
            // ...
        }
        timer.stop()
        XCTAssertFalse(timer.valid)
    }
    
    // MARK: - Delay
    func testDelay() {
        let expectation = expectationWithDescription("testDelay")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        2.second.delay {
            let delayTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            let delayTolerance = abs(2 - delayTime)
            XCTAssertLessThan(delayTolerance, 0.02)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(2.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testDelayPassingTimerInBlock() {
        let expectation = expectationWithDescription("testDelayPassingTimerInBlock")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        5.second.delay { (timer: NSTimer) -> Void in
            let delayTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            let delayTolerance = abs(5 - delayTime)
            XCTAssertLessThan(delayTolerance, 0.02)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testTimerInDelayBlock() {
        let expectation = expectationWithDescription("testTimerInDelayBlock")
        
        5.second.delay { (timer: NSTimer) -> Void in
            XCTAssertTrue(timer.valid)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Interval
    func testInterval() {
        let expectation = expectationWithDescription("testInterval")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        var count = 0
        3.second.interval {
            let intervalTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            count++
            
            if count == 2 {
                let intervalTolerance = abs(3 - intervalTime)
                XCTAssertLessThan(intervalTolerance, 0.02)
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testIntervalPassingTimerInBlock() {
        let expectation = expectationWithDescription("testIntervalPassingTimerInBlock")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        var count = 0
        3.second.interval { (timer: NSTimer) -> Void in
            let intervalTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            count++
            
            if count == 2 {
                let intervalTolerance = abs(3 - intervalTime)
                XCTAssertLessThan(intervalTolerance, 0.02)
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testTimerInIntervalBlock() {
        let expectation = expectationWithDescription("testTimerInIntervalBlock")
        
        5.second.interval { (timer: NSTimer) -> Void in
            XCTAssertTrue(timer.valid)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(0.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Delayed Interval
    func testDelayedInterval() {
        let expectation = expectationWithDescription("testDelayedInterval")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        var count = 0
        3.second.delayedInterval {
            let intervalTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            count++
            
            if count == 2 {
                let intervalTolerance = abs(6 - intervalTime)
                XCTAssertLessThan(intervalTolerance, 0.02)
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(6.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testDelayedIntervalPassingTimerInBlock() {
        let expectation = expectationWithDescription("testDelayedIntervalPassingTimerInBlock")
        
        let startTimeStamp = CFAbsoluteTimeGetCurrent()
        var count = 0
        3.second.delayedInterval { (timer: NSTimer) -> Void in
            let intervalTime = CFAbsoluteTimeGetCurrent() - startTimeStamp
            count++
            
            if count == 2 {
                let intervalTolerance = abs(6 - intervalTime)
                XCTAssertLessThan(intervalTolerance, 0.02)
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(6.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testTimerInDelayedIntervalBlock() {
        let expectation = expectationWithDescription("testTimerInDelayedIntervalBlock")
        
        5.second.delayedInterval { (timer: NSTimer) -> Void in
            XCTAssertTrue(timer.valid)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5.02) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
