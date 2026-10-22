cask "do-not-forget" do
  version "0.10.0"
  sha256 "310df83dd8f9c056b45bb0df1341124b2352807b56a91b35997aac8238a3c897"

  url "https://github.com/mkelcik/do-not-forget/releases/download/v#{version}/do-not-forget_darwin_arm64.zip"
  name "Do Not Forget"
  desc "Tray app that keeps your next meeting one glance away"
  homepage "https://mkelcik.github.io/do-not-forget/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app updates itself from GitHub Releases; the release workflow bumps this cask too.
  auto_updates true
  depends_on arch: :arm64
  depends_on :macos

  app "do-not-forget.app", target: "Do Not Forget.app"

  # Not notarised yet: without this, Gatekeeper refuses to open the app.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Do Not Forget.app"],
        writable_paths: ["{{appdir}}/Do Not Forget.app"]
  end

  uninstall quit: "io.github.mkelcik.do-not-forget"

  # Tokens for connected accounts are in the login keychain (service "do-not-forget").
  zap trash: "~/Library/Application Support/do-not-forget"
end
