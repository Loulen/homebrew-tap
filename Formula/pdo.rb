class Pdo < Formula
  desc "Prompt-Driven Orchestrator — a local daemon that runs and supervises agentic coding pipelines"
  homepage "https://github.com/Loulen/prompt-driven-orchestrator"
  version "1.101.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Loulen/prompt-driven-orchestrator/releases/download/v1.101.1/pdo-daemon-aarch64-apple-darwin.tar.xz"
      sha256 "54f1fc75f5f2b358fa7a787807ae192acd0276dcc14453654c3f937227e090f4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Loulen/prompt-driven-orchestrator/releases/download/v1.101.1/pdo-daemon-x86_64-apple-darwin.tar.xz"
      sha256 "fe98885ea8a4b0b3264af5ae0a3f0b1206f4d6f805840a46962f806470ada443"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Loulen/prompt-driven-orchestrator/releases/download/v1.101.1/pdo-daemon-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2e8585f925d510690b1d3e7824a502e9846b436225590d314b54f24fa056cfc9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Loulen/prompt-driven-orchestrator/releases/download/v1.101.1/pdo-daemon-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8ac2341e0698b652212ce4eb887f58c7190f2d3a5a38484447d0ffa87bdee97a"
    end
  end
  license "MIT"

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
