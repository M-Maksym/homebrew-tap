# This file is a template — SHA256 hashes are filled automatically by update-formula.mjs after release
class BlockchainNode < Formula
  desc "Proof-of-Stake blockchain node with terminal UI"
  homepage "https://github.com/M-Maksym/blockchain-pos"
  version "1.0.0"

  depends_on "node"

  on_macos do
    on_intel do
      url "https://github.com/M-Maksym/blockchain-pos-releases/releases/download/v#{version}/blockchain-node-macos-x64-v#{version}.tar.gz"
      sha256 "5849c52c61cd4c6d161d759bf3964474c99ccac3a4828805158afdf6396603cb"
    end
  end

  def install
    libexec.install "app.mjs"
    libexec.install "node_modules"

    (bin/"blockchain-node").write <<~SH
      #!/bin/bash
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/app.mjs" "$@"
    SH
  end

  test do
    assert_match "blockchain", shell_output("#{bin}/blockchain-node --version 2>&1", 1)
  end
end
