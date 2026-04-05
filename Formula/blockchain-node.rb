# SHA256 is updated automatically by scripts/update-formula.mjs after each release
class BlockchainNode < Formula
  desc "Proof-of-Stake blockchain node with terminal UI"
  homepage "https://github.com/M-Maksym/blockchain-pos"
  version "1.1.0"

  depends_on "node"
  depends_on :macos

  url "https://github.com/M-Maksym/blockchain-pos-releases/releases/download/v#{version}/blockchain-node-macos-v#{version}.tar.gz"
  sha256 "4e928b5a0255aed4aca49dc2433e2c0d5a3d4826c673ed1cb54e709ad6079882"

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
