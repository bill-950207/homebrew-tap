cask "airay" do
  version "0.1.0"
  sha256 :no_check

  url "https://airay.jocoding.io/api/download?ref=brew"
  name "AiRay"
  desc "Finds what AI coding agents left on your Mac and checks what deleting it would lose"
  homepage "https://airay.jocoding.io/"

  auto_updates true
  depends_on macos: ">= :sonoma"

  app "AiRay.app"

  # Credits a later purchase to Homebrew (first touch only; the app never overwrites it).
  postflight do
    unless system_command("/usr/bin/defaults", args: ["read", "net.jocoding.airay", "installRef"], print_stderr: false).success?
      system_command "/usr/bin/defaults", args: ["write", "net.jocoding.airay", "installRef", "-string", "brew"]
    end
  end

  # Application Support/AiRay is left alone: it holds the records needed to restore past cleanups.
  zap trash: [
    "~/Library/Caches/net.jocoding.airay",
    "~/Library/HTTPStorages/net.jocoding.airay",
    "~/Library/Preferences/net.jocoding.airay.plist",
    "~/Library/Saved Application State/net.jocoding.airay.savedState",
  ]
end
