cask "pr-monitor@1.12.5" do
  version "1.12.5"
  sha256 "96ce0158bfc75419695d26d39c64afe5a7d36ea5db3987dfcd06162d020f2a8d"

  url "https://github.com/jeanjacquesaka1980/pr-monitor/releases/download/v#{version}/PR.Monitor-#{version}-universal-mac.zip"
  name "PR Monitor"
  desc "GitHub pull request monitor for the macOS menu bar"
  homepage "https://github.com/jeanjacquesaka1980/pr-monitor"

  app "PR Monitor.app"
end
