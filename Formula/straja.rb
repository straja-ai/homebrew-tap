class Straja < Formula
  desc "Straja Gateway"
  homepage "https://straja.ai"
  version "0.0.0"

  if Hardware::CPU.arm?
    url "https://github.com/straja-ai/straja/releases/download/v#{version}/straja_darwin_arm64.tar.gz"
    sha256 "REPLACE_WITH_SHA256"
  else
    url "https://github.com/straja-ai/straja/releases/download/v#{version}/straja_darwin_amd64.tar.gz"
    sha256 "REPLACE_WITH_SHA256"
  end

  def install
    libexec_bundle = libexec/"bundle"
    libexec_bundle.install Dir["*"]

    (bin/"straja").write <<~EOS
      #!/usr/bin/env bash
      set -euo pipefail
      export DYLD_LIBRARY_PATH="#{libexec_bundle}/lib:${DYLD_LIBRARY_PATH:-}"
      exec "#{libexec_bundle}/straja" "$@"
    EOS
    chmod 0755, bin/"straja"

    if (libexec_bundle/"straja.yaml").exist?
      pkgshare.install libexec_bundle/"straja.yaml"
    end
  end

  def caveats
    <<~EOS
      Starter config template:
        #{pkgshare}/straja.yaml

      Run:
        straja
    EOS
  end
end
