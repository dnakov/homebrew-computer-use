class ComputerUse < Formula
  desc "macOS desktop control CLI — screenshots, input simulation, app management"
  homepage "https://github.com/dnakov/computer-use"
  url "https://github.com/dnakov/computer-use/releases/download/v0.1.0/computer-use-0.1.0.tar.gz"
  sha256 "10c5a8fa4d0f99b6e9c8ea4ef5dca362847d36539ffb81b6f1de2aba7789986b"
  version "0.1.0"
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
