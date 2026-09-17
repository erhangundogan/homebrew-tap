# Homebrew formula for videre.
#
# Ships the prebuilt binaries from the GitHub release rather than building from
# source: a source build compiles candle and ONNX Runtime, which takes minutes
# to tens of minutes, and the released artifacts are already verified (each is
# downloaded onto a clean runner and actually executed before the release is
# published).
#
# No Intel macOS bottle. ONNX Runtime ships no prebuilt binaries for
# x86_64-apple-darwin, so videre cannot be built for that target at all.
class Videre < Formula
  desc "Local-first CLI for photo and video libraries: duplicates, search, faces"
  homepage "https://github.com/erhangundogan/videre"
  version "0.31.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/erhangundogan/videre/releases/download/v#{version}/videre-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "c40e60bed15fbfd2ab2a000dc4e97125a26a9f9b22d8a0cef1f1d97b05ac9720"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/erhangundogan/videre/releases/download/v#{version}/videre-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "44e677daebd11bcede4c5bf025cad2f5654ed421a5275423f94891b249e2722f"
    end
    on_arm do
      url "https://github.com/erhangundogan/videre/releases/download/v#{version}/videre-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d730640cab9347430de9ed503f70ea34d574b49770f3b365aeedd4059138b62d"
    end
  end

  def install
    bin.install "videre"
  end

  def caveats
    <<~EOS
      Model weights are downloaded on first use, not at install:
        videre embed  ~780 MB (semantic search)
        videre faces  ~180 MB (face detection)

      scan, dedupe, fix-dates, prune, stats and locations need no model at all.
    EOS
  end

  test do
    assert_match "videre #{version}", shell_output("#{bin}/videre --version")
  end
end
