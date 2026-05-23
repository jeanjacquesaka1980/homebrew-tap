cask "pr-monitor" do
  version "1.12.4"
  sha256 "c81f5c887036a8c3912ef0f72a8445f7643a5829db60992d11a48600e28ab3ef"

  url "https://github.com/jeanjacquesaka1980/pr-monitor/releases/download/v#{version}/PR.Monitor-#{version}-universal-mac.zip"
  name "PR Monitor"
  desc "GitHub pull request monitor for the macOS menu bar"
  homepage "https://github.com/jeanjacquesaka1980/pr-monitor"

  preflight do
    if system_command("/usr/bin/pgrep", args: ["-ix", "PR Monitor"], print_stderr: false, must_succeed: false).exit_status == 0
      puts "PR Monitor is running -- quitting it before upgrade..."
      system_command("/usr/bin/pkill", args: ["-ix", "PR Monitor"], print_stderr: false, must_succeed: false)
      10.times do
        break if system_command("/usr/bin/pgrep", args: ["-ix", "PR Monitor"], print_stderr: false, must_succeed: false).exit_status != 0
        sleep 1
      end
      sleep 2
    end

    if File.exist?("/Applications/PR Monitor.app")
      system_command "/usr/bin/xattr",
        args: ["-cr", "/Applications/PR Monitor.app"],
        print_stderr: false,
        must_succeed: false
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

  postflight do
    system_command "/usr/bin/xattr",
      args: ["-dr", "com.apple.quarantine", "#{appdir}/PR Monitor.app"],
      print_stderr: false,
      must_succeed: false
  end

  app "PR Monitor.app"

  caveats <<~EOS
    Getting started:
      1. Launch PR Monitor from Spotlight (Cmd+Space -> PR Monitor) or Applications.
      2. Authenticate with GitHub if prompted -- the app will guide you through it.
      3. To upgrade in future: just run brew upgrade --cask pr-monitor

    Troubleshooting: https://github.com/jeanjacquesaka1980/pr-monitor#troubleshooting
  EOS

  zap trash: [
    "~/Library/Application Support/PR Monitor",
    "~/Library/LaunchAgents/com.pr-monitor.app.plist",
    "~/Library/Preferences/com.pr-monitor.app.plist",
  ]
end
