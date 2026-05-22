cask "pr-monitor" do
  version "1.12.0"
  sha256 "817280296e0b3799ae0c6d53e95c524338c081098dcd01c42d3aa78faa77e546"

  url "https://github.com/jeanjacquesaka1980/pr-monitor/releases/download/v#{version}/PR.Monitor-#{version}-universal-mac.zip"
  name "PR Monitor"
  desc "GitHub pull request monitor for the macOS menu bar"
  homepage "https://github.com/jeanjacquesaka1980/pr-monitor"

  preflight do
    if system_command("/usr/bin/pgrep", args: ["-ix", "PR Monitor"], print_stderr: false, must_succeed: false).exit_status == 0
      odie "PR Monitor is currently running. Quit it first, then re-run:\n  brew upgrade --cask pr-monitor"
    end

    caskroom_entry = File.join(ENV.fetch("HOMEBREW_PREFIX", "/usr/local"), "Caskroom", "pr-monitor")
    if File.exist?("/Applications/PR Monitor.app") && !File.exist?(caskroom_entry)
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
