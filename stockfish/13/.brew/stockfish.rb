class Stockfish < Formula
  desc "Strong open-source chess engine"
  homepage "https://stockfishchess.org/"
  url "https://github.com/official-stockfish/Stockfish/archive/sf_13.tar.gz"
  sha256 "15d14721b3be17c597535bdbb44fb951a1ee948312d90fbf55fa0e52b8b81d62"
  license "GPL-3.0-only"
  head "https://github.com/official-stockfish/Stockfish.git"

  livecheck do
    url :stable
    strategy :github_latest
    regex(%r{href=.*?/tag/(?:sf[._-])?v?(\d+(?:\.\d+)*)["' >]}i)
  end

  def install
    arch = Hardware::CPU.arm? ? "apple-silicon" : "x86-64-modern"

    system "make", "-C", "src", "build", "ARCH=#{arch}"
    bin.install "src/stockfish"
  end

  test do
    system "#{bin}/stockfish", "go", "depth", "20"
  end
end
