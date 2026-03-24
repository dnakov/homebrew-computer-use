class ComputerUse < Formula
  desc "macOS desktop control CLI — screenshots, input simulation, app management"
  homepage "https://github.com/dnakov/computer-use"
  url "https://github.com/dnakov/computer-use/releases/download/v0.2.1/computer-use-0.2.1.tar.gz"
  sha256 "8e718690d6df06b40cd401c024a4a326685cd385cacc30b5a74f2fdc895a245e"
  version "0.2.1"
  license "MIT"

  def install
    bin.install "computer-use"
    app_dir = libexec/"TeachOverlay.app"
    app_dir.mkpath
    cp_r "TeachOverlay.app/.", app_dir
    ln_sf libexec/"TeachOverlay.app", bin/"TeachOverlay.app"
  end

  def caveats
    <<~EOS
      computer-use requires macOS permissions:
        - Accessibility (for input simulation)
        - Screen Recording (for screenshots)
      Grant in System Settings > Privacy & Security.
    EOS
  end

  test do
    assert_match "displayId", shell_output("#{bin}/computer-use display list-all")
    assert_match version.to_s, shell_output("#{bin}/computer-use --version")
  end
end
