class ComputerUse < Formula
  desc "macOS desktop control CLI — screenshots, input simulation, app management"
  homepage "https://github.com/dnakov/computer-use"
  url "https://github.com/dnakov/computer-use/releases/download/v0.2.0/computer-use-0.2.0.tar.gz"
  sha256 "49abd64f8eac62a60711db164f4547d8c34d3cef34ed26a5fa13537a1ea56086"
  version "0.2.0"
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
