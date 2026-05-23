cask "pr-monitor" do
  version "1.12.0"
  sha256 "817280296e0b3799ae0c6d53e95c524338c081098dcd01c42d3aa78faa77e546"

  url "https://github.com/jeanjacquesaka1980/pr-monitor/releases/download/v#{version}/PR.Monitor-#{version}-universal-mac.zip"
  name "PR Monitor"
  desc "GitHub pull request monitor for the macOS menu bar"
  homepage "https://github.com/jeanjacquesaka1980/pr-monitor"

  preflight do
    if system_command("/usr/bin/pgrep", args: ["-ix", "PR Monitor"], print_stderr: false, must_succeed: false).exit_status == 0
      puts "PR Monitor is running -- quitting it before upgrade..."
      system_command("/usr/bin/osascript", args: ["-e", 'quit app "PR Monitor"'], print_stderr: false, must_succeed: false)
      sleep 2
    end

    caskroom_entry = File.join(ENV.fetch("HOMEBREW_PREFIX", "/usr/local"), "Caskroom", "pr-monitor")
    if File.exist?("/Applications/PR Monitor.app") && !File.exist?(caskroom_entry)
      odie <<~EOS
        PR Monitor is installed outside Homebrew (e.g. via npm run start).
        Move it to Trash first:
          mv "/Applications/PR Monitor.app" ~/.Trash/
        Then re-run:
          brew install --cask pr-monitor

        Troubleshooting: https://github.com/jeanjacquesaka1980/pr-monitor#troubleshooting
      EOS
    end
  end

  app "PR Monitor.app"

  caveats <<~EOS
    Getting started:
      1. Launch PR Monitor from Spotlight (Cmd+Space -> PR Monitor) or Applications.
      2. Authenticate with GitHub if prompted -- the app will guide you through it.
      3. To upgrade in future: quit the app, then run brew upgrade --cask pr-monitor

    Troubleshooting: https://github.com/jeanjacquesaka1980/pr-monitor#troubleshooting
  EOS

  zap trash: [
    "~/Library/Application Support/PR Monitor",
    "~/Library/LaunchAgents/com.pr-monitor.app.plist",
    "~/Library/Preferences/com.pr-monitor.app.plist",
  ]
end
