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
  version "0.42.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/erhangundogan/videre/releases/download/v#{version}/videre-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "0ed670bf84f961f7a9972de8eff3e6766463c2c7100a3fd4279b0b6b0be5bf4c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/erhangundogan/videre/releases/download/v#{version}/videre-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c3c3c3d05c2cd46b2052fb74eb6ddc349b0852590da37b8dbf359b9e3c8ec2fe"
    end
    on_arm do
      url "https://github.com/erhangundogan/videre/releases/download/v#{version}/videre-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "827d51b7a81f79bf0011d4160d78affe08638d088e7e16f1dde1c783724ab22f"
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
