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
  version "0.15.7"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/erhangundogan/videre/releases/download/v#{version}/videre-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "de7f0752fb63f957c365c0fc16f363246d772a4254abe854c5e29be7358b6ade"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/erhangundogan/videre/releases/download/v#{version}/videre-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ed6d407b291be127df7d6013d58a0a6956de931ca5d01af2f620e149c823f749"
    end
    on_arm do
      url "https://github.com/erhangundogan/videre/releases/download/v#{version}/videre-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7fdf7405e8018cf2668ee21e7eb6993266ea4a31df14ed949ef120a8ad6a641b"
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
