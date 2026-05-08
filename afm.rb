class Afm < Formula
  desc "Apple Foundation Models + MLX local models — OpenAI-compatible API, WebUI, all Swift (STAGING)"
  homepage "https://github.com/scouzi1966/maclocal-api"
  url "https://github.com/scouzi1966/maclocal-api/releases/download/v0.9.12/afm-v0.9.12-arm64.tar.gz"
  version "0.9.12"
  sha256 "d0ed82bb728dbc76307cfa7b9dc4ae768643d1ac1c65f39f486860f1b6d0495a"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "afm"

    bundle_dir = "MacLocalAPI_MacLocalAPI.bundle"
    if Dir.exist?(bundle_dir)
      (libexec/bundle_dir).mkpath
      (libexec/bundle_dir).install Dir["#{bundle_dir}/*"]
    end

    if Dir.exist?("Resources/webui")
      (share/"afm/webui").mkpath
      (share/"afm/webui").install Dir["Resources/webui/*"]
    end
  end

  def caveats
    <<~EOS
      ⚠️  STAGING BUILD — not for production use.
      This is v0.9.12 served from a staging tap for validation before
      promotion to the main scouzi1966/afm tap. Switch to the main tap
      for stable use:
        brew untap scouzi1966/afm-staging
        brew install scouzi1966/afm/afm
    EOS
  end

  test do
    assert_match "v0.9.12", shell_output("#{bin}/afm --version")
  end
end
