class Weaver < Formula
  desc "Command-line tool for Weaver"
  homepage "https://github.com/scribd/Weaver"
  url "https://github.com/scribd/Weaver/archive/refs/tags/1.1.5.tar.gz"
  sha256 "746b0506fdae675bfa0ef0353f38f1ab5ac6ba465bd17f85cb7b9561fb4e1da1"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "c10ee3d986ce1eed7fad37e36db3e2c15680728bc26ed23cd918e8fff2cb30f7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "fb165cdf2e08fcfcb08c58b9f94071adbab0a3274b6cdae12955f24c04364c82"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e75a5cba435b5040061fcb2edd78840a8624c194fb81c28df14727b284dffa7c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4f498e3cfaf9a3d298f4fca470de2f80e67163fec39843f58210027b034e5131"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "3417ed4fecfb8f29f7bc57131982c81c28548ab3a105361d1839d20a23ee7d2a"
    sha256 cellar: :any_skip_relocation, sonoma:         "872b99e74c0668d9fd7bc4841a7dc8ec33a48354e2d711eeaf0dea082f6b14e5"
    sha256 cellar: :any_skip_relocation, ventura:        "c5c0410a6d4150b3bd2faed4d790136a3e621a5736d7d144530067d9c1133936"
    sha256 cellar: :any_skip_relocation, monterey:       "1a0dd68132efacde4843465bf03d3327d7c4d49ad3c053f4944495bdb63169b9"
    sha256 cellar: :any_skip_relocation, big_sur:        "8f1f0c9b199d3a9336f70d4059e41a1b8965dd0ca8de5b087b93adf4b5e99b53"
  end

  depends_on xcode: ["11.2", :build]

  uses_from_macos "swift"

  conflicts_with "service-weaver", because: "both install a `weaver` binary"

  # Fetch a copy of SourceKitten in order to fix build with newer Swift.
  resource "SourceKitten" do
    on_sequoia :or_newer do
      # https://github.com/scribd/Weaver/blob/1.1.5/Package.resolved#L99-L100
      url "https://github.com/jpsim/SourceKitten.git",
          tag:      "0.29.0",
          revision: "77a4dbbb477a8110eb8765e3c44c70fb4929098f"

      # Backport of import from HEAD
      patch :DATA
    end
  end

  def install
    if OS.mac? && MacOS.version >= :sequoia
      (buildpath/"SourceKitten").install resource("SourceKitten")
      system "swift", "package", "--disable-sandbox", "edit", "SourceKitten", "--path", buildpath/"SourceKitten"
    end

    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    # Weaver uses Sourcekitten and thus, has the same sandbox issues.
    # Rewrite test after sandbox issues investigated.
    # https://github.com/Homebrew/homebrew/pull/50211
    system bin/"weaver", "version"
  end
end

__END__
diff --git a/Source/SourceKittenFramework/SwiftDocs.swift b/Source/SourceKittenFramework/SwiftDocs.swift
index 1d2473c..70de287 100644
--- a/Source/SourceKittenFramework/SwiftDocs.swift
+++ b/Source/SourceKittenFramework/SwiftDocs.swift
@@ -10,6 +10,14 @@
 import SourceKit
 #endif

+#if os(Linux)
+import Glibc
+#elseif os(Windows)
+import CRT
+#else
+import Darwin
+#endif
+
 /// Represents docs for a Swift file.
 public struct SwiftDocs {
     /// Documented File.
