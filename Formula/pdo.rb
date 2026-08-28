class Pdo < Formula
  desc "Prompt-Driven Orchestrator — a local daemon that runs and supervises agentic coding pipelines"
  homepage "https://github.com/Loulen/prompt-driven-orchestrator"
  version "1.44.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Loulen/prompt-driven-orchestrator/releases/download/v1.44.0/pdo-daemon-aarch64-apple-darwin.tar.xz"
      sha256 "4fea7cda783cb113144f2bde7bd26420abc848b549197d4907731f95fe4155bc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Loulen/prompt-driven-orchestrator/releases/download/v1.44.0/pdo-daemon-x86_64-apple-darwin.tar.xz"
      sha256 "25dada79a8fbb157552ab93543c7b112d488683227a23535c318219f4481d822"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Loulen/prompt-driven-orchestrator/releases/download/v1.44.0/pdo-daemon-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b892ebb6b636176946e0e8cedfc82715dd16d5a1d2f6dded1f4cb25ca592e217"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Loulen/prompt-driven-orchestrator/releases/download/v1.44.0/pdo-daemon-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0412abad9058555e8375836b00ffb1a44703ecff7b406d56ffbc1bf520d80d42"
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
