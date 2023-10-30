import Cocoa

class AutoClickerApp: NSApplication, NSApplicationDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    var isClicking = false
    var timer: Timer?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named: "AutoClickerIcon")
            button.action = #selector(toggleAutoClicker)
        }
        constructMenu()
    }

    func constructMenu() {
        let menu = NSMenu()

        let startStopItem = NSMenuItem()
        menu.addItem(startStopItem)

        startStopItem.title = "Start AutoClicker"
        startStopItem.action = #selector(toggleAutoClicker)
        statusItem.menu = menu
    }

    @objc func toggleAutoClicker() {
        if isClicking {
            stopClicking()
        } else {
            startClicking()
        }
    }

    func startClicking() {
        isClicking = true
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(clickMouse), userInfo: nil, repeats: true)
    }

    func stopClicking() {
        isClicking = false
        timer?.invalidate()
    }

    @objc func clickMouse() {
        let mouseDown = CGEvent(mouseEventSource: nil, mouseType: .leftMouseDown, mouseCursorPosition: .zero, mouseButton: .left)
        let mouseUp = CGEvent(mouseEventSource: nil, mouseType: .leftMouseUp, mouseCursorPosition: .zero, mouseButton: .left)

        mouseDown?.post(tap: .cghidEventTap)
        mouseUp?.post(tap: .cghidEventTap)
    }
}

let app = AutoClickerApp.shared
NSApp.delegate = app
app.run()
