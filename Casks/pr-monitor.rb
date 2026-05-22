cask "pr-monitor" do
  version "1.11.0"
  sha256 "f3d1b3d9e2f8ec5b4374c21f1ba3fdb80e4b65b9dd8243884a0c3c2aa69c6215"

  url "https://github.com/jeanjacquesaka1980/pr-monitor/releases/download/v#{version}/PR.Monitor-#{version}-universal-mac.zip"
  name "PR Monitor"
  desc "GitHub pull request monitor for the macOS menu bar"
  homepage "https://github.com/jeanjacquesaka1980/pr-monitor"

  preflight do
    if system_command("/usr/bin/pgrep", args: ["-ix", "PR Monitor"], print_stderr: false, must_succeed: false).exit_status == 0
      odie "PR Monitor is currently running. Quit it first, then re-run:\n  brew upgrade --cask pr-monitor"
    end

    app_path = "/Applications/PR Monitor.app"
    caskroom_path = "#{caskroom}/pr-monitor"
    if File.exist?(app_path) && !File.exist?(caskroom_path)
      odie "PR Monitor is installed outside Homebrew. Move it to Trash first:\n  mv \"/Applications/PR Monitor.app\" ~/.Trash/\nThen re-run:\n  brew install --cask pr-monitor"
    end
  end

  app "PR Monitor.app"

  zap trash: [
    "~/Library/Application Support/PR Monitor",
    "~/Library/LaunchAgents/com.pr-monitor.app.plist",
    "~/Library/Preferences/com.pr-monitor.app.plist",
  ]
end
