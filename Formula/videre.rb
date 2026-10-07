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
  version "0.57.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/erhangundogan/videre/releases/download/v#{version}/videre-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "2ab67da489061699aa798c5b03ec7271fdbcbc4200cc24d4353bbd08c3ef129a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/erhangundogan/videre/releases/download/v#{version}/videre-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "42b99418e51efc3f789f0895ffda34cc0b6c5cc3279595a9dda2255da48322b4"
    end
    on_arm do
      url "https://github.com/erhangundogan/videre/releases/download/v#{version}/videre-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "743e3b325fe2e7473218000c9756f7b87e1bef620ff1b9b69b7da5a937a27164"
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
