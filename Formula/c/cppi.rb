class Cppi < Formula
  desc "Indent C preprocessor directives to reflect their nesting"
  homepage "https://www.gnu.org/software/cppi/"
  url "https://ftp.gnu.org/gnu/cppi/cppi-1.18.tar.xz"
  mirror "https://ftpmirror.gnu.org/cppi/cppi-1.18.tar.xz"
  sha256 "12a505b98863f6c5cf1f749f9080be3b42b3eac5a35b59630e67bea7241364ca"
  license "GPL-3.0-or-later"

  no_autobump! because: :requires_manual_review

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "ad3274881902eed64b3d3a8d0c846e7dcb09e13d6dd972551de0cc2fa09f89a0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "60bcb5a1dba625e152384d1dfbcebbec2bfc552a6744a42ac8c9131a50d22f51"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "95ef8763f3cea6d0b2e699b1a7a0fcfbc8a60e568ee6d2587927b591b772940f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "bbc7be8b21e6ba9f0f4eec49b22f43f5900af2628c8437c5b14e235169a8c22d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "00d594375b23e688f18b3abe9f6b892c23a83c5ecc4e8d27ce8a414c3f2070d6"
    sha256 cellar: :any_skip_relocation, sonoma:         "a7bda8ab50226a4110e0d025d6ce5ae5b1a6ad85a1111f8a0f58442af264ad86"
    sha256 cellar: :any_skip_relocation, ventura:        "eeed7bf193f6800050418eca626511ba5e3c76fb4ebd4f11ad67e93f1924b569"
    sha256 cellar: :any_skip_relocation, monterey:       "d1f346b4ed988e78ec44e4019b64c182bb660290d3cafdb65ab005321a554bec"
    sha256 cellar: :any_skip_relocation, big_sur:        "831418bd1a4c710184c6efb0b4a0476077f876cceedb9245dcf994ac7322e91b"
    sha256 cellar: :any_skip_relocation, catalina:       "24e10e144f6a86bb893f886cb631b9f57a3c3073fc19a0829e512c87db465ef0"
    sha256 cellar: :any_skip_relocation, mojave:         "9091ecb45e38512cdeb73d92078d1ee9c7bd8e5bce9d1698da9a53e2ae3f8b3c"
    sha256 cellar: :any_skip_relocation, high_sierra:    "bc8253f982b219088603021d510a6e7ee6d692ff5f693da19b32d0431bc9c9b4"
    sha256 cellar: :any_skip_relocation, sierra:         "d4c044247ba8a12f1462089bfa22602547894f0a9081fce21c4800e192a526ae"
    sha256 cellar: :any_skip_relocation, el_capitan:     "970e44d2a7a340fe29577f92c4b6dfcbac17f3aef35e6085197b668c4cd9013f"
    sha256                               arm64_linux:    "9f29c60a3728f80b7695a91ea71da089355422a06565faafa05074b6ddfef69d"
    sha256                               x86_64_linux:   "4c51c1d89a082e419ba33ab1c257fae2b1882125070d2e89ab2e49258164a7e5"
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "check"
    system "make", "install"
  end

  test do
    test = <<~C
      #ifdef TEST
      #include <homebrew.h>
      #endif
    C
    assert_equal <<~C, pipe_output(bin/"cppi", test, 0)
      #ifdef TEST
      # include <homebrew.h>
      #endif
    C
  end
end
