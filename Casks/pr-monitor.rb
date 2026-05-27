cask "pr-monitor" do
  version "1.13.2"
  sha256 "e56ced0ec2cc3232c72ee48225c3c19c95545186d24245000ecef9dbfbae2d37"

  url "https://github.com/jeanjacquesaka1980/pr-monitor/releases/download/v#{version}/PR.Monitor-#{version}-universal-mac.zip"
  name "PR Monitor"
  desc "GitHub pull request monitor for the macOS menu bar"
  homepage "https://github.com/jeanjacquesaka1980/pr-monitor"

  preflight do
    system_command "/usr/bin/pkill",
      args: ["-ix", "PR Monitor"],
      print_stderr: false,
      must_succeed: false
  end

  postflight do
    system_command "/usr/bin/xattr",
      args: ["-dr", "com.apple.quarantine", "#{appdir}/PR Monitor.app"],
      print_stderr: false,
      must_succeed: false
  end

  app "PR Monitor.app"

  zap trash: [
    "~/Library/Application Support/PR Monitor",
    "~/Library/LaunchAgents/com.pr-monitor.app.plist",
    "~/Library/Preferences/com.pr-monitor.app.plist",
  ]
end
