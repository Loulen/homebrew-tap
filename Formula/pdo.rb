class Pdo < Formula
  desc "Prompt-Driven Orchestrator — a local daemon that runs and supervises agentic coding pipelines"
  homepage "https://github.com/Loulen/prompt-driven-orchestrator"
  version "1.114.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Loulen/prompt-driven-orchestrator/releases/download/v1.114.0/pdo-daemon-aarch64-apple-darwin.tar.xz"
      sha256 "e3b8226c62be90c2a28dcd44aaeb5527764fc440469ca6e6ed7a1a35825fe957"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Loulen/prompt-driven-orchestrator/releases/download/v1.114.0/pdo-daemon-x86_64-apple-darwin.tar.xz"
      sha256 "64785d074b04f19737b1de987ff60adf746b459da0b09cbcd38cee46f36a24e3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Loulen/prompt-driven-orchestrator/releases/download/v1.114.0/pdo-daemon-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9023b2bb29e20624177004936cfec3a9e92ddd1fc60ce618af0ca2aacb1415d3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Loulen/prompt-driven-orchestrator/releases/download/v1.114.0/pdo-daemon-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5e8f721ec801ad1175953cc45360a4f4c959e409d4919b0d88a5848a79faa545"
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
