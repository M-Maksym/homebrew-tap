# This file is a template — SHA256 hashes are filled automatically by update-formula.mjs after release
class BlockchainNode < Formula
  desc "Proof-of-Stake blockchain node with terminal UI"
  homepage "https://github.com/M-Maksym/blockchain-pos"
  version "1.0.2"

  depends_on "node"

  on_macos do
    on_intel do
      url "https://github.com/M-Maksym/blockchain-pos-releases/releases/download/v#{version}/blockchain-node-macos-x64-v#{version}.tar.gz"
      sha256 "ac2649d6f8d5278b501a4517872a577ae33e866fa49e16a89d3d0adfd49cbb30"
    end
  end

  def install
    libexec.install "app.mjs"
    libexec.install "node_modules"
    libexec.install "contracts"

    (bin/"blockchain-node").write <<~SH
      #!/bin/bash
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/app.mjs" "$@"
    SH
  end

  test do
    assert_match "blockchain", shell_output("#{bin}/blockchain-node --version 2>&1", 1)
  end
end
