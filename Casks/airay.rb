cask "airay" do
  version "0.1.0"
  sha256 :no_check

  url "https://airay.jocoding.io/api/download?ref=brew"
  name "AiRay"
  desc "Finds what AI coding agents left on your Mac and checks what deleting it would lose"
  homepage "https://airay.jocoding.io/"

  auto_updates true
  depends_on macos: :sonoma

  app "AiRay.app"

  # Opens AiRay once the app is in place (it updates itself from then on). The installer runs before the app is
  # moved and postflight steps are sandboxed away from LaunchServices, so this waits a moment in the background.
  installer script: {
    executable:   "/bin/sh",
    args:         ["-c", "(sleep 3; /usr/bin/open -b net.jocoding.airay) >/dev/null 2>&1 &"],
    must_succeed: false,
  }

  # Application Support/AiRay is left alone: it holds the records needed to restore past cleanups.
  zap trash: [
    "~/Library/Caches/net.jocoding.airay",
    "~/Library/HTTPStorages/net.jocoding.airay",
    "~/Library/Preferences/net.jocoding.airay.plist",
    "~/Library/Saved Application State/net.jocoding.airay.savedState",
  ]
end
