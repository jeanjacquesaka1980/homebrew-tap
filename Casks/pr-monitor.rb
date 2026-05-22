cask "pr-monitor" do
  version "1.9.0"
  sha256 "62b83042997268340cdf5ba3e5a1e33d3f3eab388f59e5192a59b1d779707eeb"

  url "https://github.com/jeanjacquesaka1980/pr-monitor/releases/download/v#{version}/PR.Monitor-#{version}-universal-mac.zip"
  name "PR Monitor"
  desc "GitHub pull request monitor for the macOS menu bar"
  homepage "https://github.com/jeanjacquesaka1980/pr-monitor"

  app "PR Monitor.app"

  zap trash: [
    "~/Library/Application Support/PR Monitor",
    "~/Library/LaunchAgents/com.pr-monitor.app.plist",
    "~/Library/Preferences/com.pr-monitor.app.plist",
  ]
end
