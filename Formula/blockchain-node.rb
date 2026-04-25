# SHA256 is updated automatically by scripts/update-formula.mjs after each release
class BlockchainNode < Formula
  desc "Proof-of-Stake blockchain node with terminal UI"
  homepage "https://github.com/M-Maksym/blockchain-pos"
  version "1.1.1"

  depends_on "node"
  depends_on :macos

  url "https://github.com/M-Maksym/blockchain-pos-releases/releases/download/v#{version}/blockchain-node-macos-v#{version}.tar.gz"
  sha256 "df5c84f8114979ed34605f7510f53d886828bba8c1f91d7c26d7804f96ddfc15"

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
