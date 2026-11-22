class Pdo < Formula
  desc "Prompt-Driven Orchestrator — a local daemon that runs and supervises agentic coding pipelines"
  homepage "https://github.com/Loulen/prompt-driven-orchestrator"
  version "2.88.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Loulen/prompt-driven-orchestrator/releases/download/v2.88.0/pdo-daemon-aarch64-apple-darwin.tar.xz"
      sha256 "a70eb924e5c4abd354dc3fc268591ad572b73305555a9b9e2aa7644d5c6d847c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Loulen/prompt-driven-orchestrator/releases/download/v2.88.0/pdo-daemon-x86_64-apple-darwin.tar.xz"
      sha256 "cb120c213f42d097438a87b05f27b3c6d8f31dcd02616825efbcf7d933a97b65"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Loulen/prompt-driven-orchestrator/releases/download/v2.88.0/pdo-daemon-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b23c4c89da7ebae1b88582559914e16697d101392835ef6d976abbd806e5bf0f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Loulen/prompt-driven-orchestrator/releases/download/v2.88.0/pdo-daemon-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1177754b17da0d4ae9f8a91d67d1b12b4ede7c8f6fa6f12da4338a99448e085c"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "pdo"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "pdo"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "pdo"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "pdo"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
