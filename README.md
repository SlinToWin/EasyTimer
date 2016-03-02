# EasyTimer
#####Natural language syntax for an easy way to use NSTimer in Swift for delaying code or repeating code.

Heavily influenced by [SwiftyTimer](https://github.com/radex/SwiftyTimer) - Author: Radek Pietruszewski -  [radex](https://github.com/radex)

## Installation

#### Manually
Add the files in the 'Sources' folder to your project and you will be ready to go!

## Usage

You can easily schedule three types of timers (repeating, repeating with delay, and delay) - Each of these will return a new NSTimer instance

Schedule a timer that will repeat and call block immediately
```swift
// Will repeat code in block every 2 seconds starting immediately
2.second.interval {
  print("Repeat immediately!")
}

// or with timer passed to the block
2.second.interval { (timer: NSTimer) -> Void in
  print("Repeat immediately! Do something with timer.")
}
```

Schedule a timer that will repeat and call block after time interval delay
```swift
// Will repeat code in block every 2 seconds after a 2 second delay
2.second.delayedInterval {
  print("Repeat after delay!")
}

// or with timer passed to the block
2.second.delayedInterval { (timer: NSTimer) -> Void in
  print("Repeat after delay! Do something with timer.")
}
```

Schedule a timer that will call block once after time interval
```swift
// Will execute code in block once after 2 second delay
2.second.delay {
  print("Delay ended!")
}

// or with timer passed to the block
2.second.delay { (timer: NSTimer) -> Void in
  print("Delay ended! Do something with timer.")
}
```

Call `start()` to schedule timers created using `timer(repeats, block)`. You can optionally pass the run loop and run loop modes:

```swift
timer.start()
timer.start(modes: NSDefaultRunLoopMode, NSEventTrackingRunLoopMode)
```

Call `stop()` to invalidate a timer

```swift
timer.stop()
```

## Author and License

#### Author
[Niklas Fahl (fahlout)](http://bit.ly/fahlout) - iOS Developer ([LinkedIn](http://bit.ly/linked-in-niklas-fahl))

#### License
Copyright (c) 2012 The Board of Trustees of The University of Alabama
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

 1. Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.
 2. Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.
 3. Neither the name of the University nor the names of the contributors
    may be used to endorse or promote products derived from this software
    without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
OF THE POSSIBILITY OF SUCH DAMAGE.
