class Afm < Formula
  desc "Apple Foundation Models + MLX local models — OpenAI-compatible API, WebUI, all Swift (STAGING)"
  homepage "https://github.com/scouzi1966/maclocal-api"
  url "https://github.com/scouzi1966/maclocal-api/releases/download/v0.9.11/afm-v0.9.11-arm64.tar.gz"
  version "0.9.11"
  sha256 "0b1b8d8406760fe47deba1328664efc3b505f291a61fd9de1c2537e895bffc1d"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "afm"

    # Metallib resource bundle (SPM-generated)
    bundle_dir = "MacLocalAPI_MacLocalAPI.bundle"
    if Dir.exist?(bundle_dir)
      (libexec/bundle_dir).mkpath
      (libexec/bundle_dir).install Dir["#{bundle_dir}/*"]
    end

    # WebUI assets
    if Dir.exist?("Resources/webui")
      (share/"afm/webui").mkpath
      (share/"afm/webui").install Dir["Resources/webui/*"]
    end
  end

  def caveats
    <<~EOS
      ⚠️  STAGING BUILD — not for production use.
      This is v0.9.11 served from a staging tap for validation before promotion
      to the main scouzi1966/afm tap. Switch to the main tap for stable use:
        brew untap scouzi1966/afm-staging
        brew install scouzi1966/afm/afm

      Quick start:
        afm -w                                  # WebUI + Apple Foundation Models
        afm -w -g                               # WebUI + API gateway (discovers Ollama, LM Studio, etc.)
        afm -s "Hello, AI!"                     # Single prompt mode

      MLX Local Models (v0.9.11+):
        afm mlx -m mlx-community/Qwen2.5-0.5B-Instruct-4bit -s "Hello"
        afm mlx -m mlx-community/gemma-3-4b-it-8bit -w
        afm mlx -w                              # Interactive model picker

      More:
        afm --help                              # Full options
        afm mlx --help                          # MLX options
    EOS
  end

  test do
    assert_match "v0.9.11", shell_output("#{bin}/afm --version")
  end
end
