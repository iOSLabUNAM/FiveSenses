//
//  RunnerButton
//  FiveSenses
//
//  Created by Luis Ezcurdia on 10/17/18.
//  Copyright © 2018 fi.unam.mx. All rights reserved.
//

import UIKit

class RunnerButton: UIButton {
    private var active: Bool? = false {
        didSet {
            if let active = self.active, active {
                setTitle("Stop", for: .normal)
            } else {
                setTitle("Start", for: .normal)
            }
        }
    }

    public func isActive() -> Bool {
        return self.active ?? false
    }

    public func switchState() -> Bool {
        self.active = !(self.active ?? false)
        return self.active!
    }
}
