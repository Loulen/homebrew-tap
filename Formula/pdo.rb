class Pdo < Formula
  desc "Prompt-Driven Orchestrator — a local daemon that runs and supervises agentic coding pipelines"
  homepage "https://github.com/Loulen/prompt-driven-orchestrator"
  version "1.63.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Loulen/prompt-driven-orchestrator/releases/download/v1.63.0/pdo-daemon-aarch64-apple-darwin.tar.xz"
      sha256 "93842c75c20cdcab50f54a46de77951c0ab9cfee06567fd1b18c04228a505738"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Loulen/prompt-driven-orchestrator/releases/download/v1.63.0/pdo-daemon-x86_64-apple-darwin.tar.xz"
      sha256 "811e26aa4f09dbcf476509bf7d57546277945134e9b40663a124cc6b7f9b049e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Loulen/prompt-driven-orchestrator/releases/download/v1.63.0/pdo-daemon-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b5de61f5b7af3a3af4ce507a394dffb7f7f564f781f39801553d7e76e6c18c97"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Loulen/prompt-driven-orchestrator/releases/download/v1.63.0/pdo-daemon-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6097f1eda6c5368b98bea51311e98dbe840b7dde1161ccab653dcc9a2b061258"
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
