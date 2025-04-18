class Keploy < Formula
  desc "Testing Toolkit creates test-cases and data mocks from API calls, DB queries"
  homepage "https://keploy.io"
  url "https://github.com/keploy/keploy/archive/refs/tags/v2.4.17.tar.gz"
  sha256 "3fad08cec0ae7ea8dec1f5a2cc791b2367bcbed5d7612ce1290620c96b8c8db3"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a86b4823c98dac43922626a082c0281c05ba6230fed121d97f2560dbdd6b4ba2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a86b4823c98dac43922626a082c0281c05ba6230fed121d97f2560dbdd6b4ba2"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a86b4823c98dac43922626a082c0281c05ba6230fed121d97f2560dbdd6b4ba2"
    sha256 cellar: :any_skip_relocation, sonoma:        "672efc18df3ef2ad5fa4a9fde73aeb96a791de3dcf6025924b40eb8d789afa93"
    sha256 cellar: :any_skip_relocation, ventura:       "672efc18df3ef2ad5fa4a9fde73aeb96a791de3dcf6025924b40eb8d789afa93"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "79aa27b0c50477e4d5c27e8b7373bceae309b1f53af8290f1d1046750d29bbe9"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}")
  end

  test do
    system bin/"keploy", "config", "--generate", "--path", testpath
    assert_match "# Generated by Keploy", (testpath/"keploy.yml").read

    output = shell_output("#{bin}/keploy templatize --path #{testpath}")
    assert_match "No test sets found to templatize", output

    assert_match version.to_s, shell_output("#{bin}/keploy --version")
  end
end
