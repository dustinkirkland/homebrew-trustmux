class Trustmux < Formula
  include Language::Python::Virtualenv

  desc "Monitor and interact with tmux/Byobu sessions from your phone"
  homepage "https://trustmux.app"

  url "https://files.pythonhosted.org/packages/3b/dd/bb0d010fd1ab3ebe9fda2c08ee4336f03e7768cdaa47d957a8f2f2bea4f2/trustmux-7.12.tar.gz"
  sha256 "a5f91da59cb6dd734f76f42a0afee4b8006a8fc93542694d00d01330f70c65bf"
  version "7.12"
  license "GPL-3.0-or-later"

  head "https://github.com/dustinkirkland/byobu.git", branch: "master"

  depends_on "python@3.12"
  depends_on "tmux"
  depends_on "rust" => :build  # required to compile cryptography's Rust extension

  resource "tornado" do
    url "https://files.pythonhosted.org/packages/50/57/6d7303a77ae439d9189108f76c0c4fd89ee5e2cc8387bffb55232565c4ed/tornado-6.5.6.tar.gz"
    sha256 "9a365179fe8ff6b8766f602c0f67c185d778193e9bdd828b19f0b6ed7764177d"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/1b/7d/92392ff7815c21062bea51aa7b87d45576f649f16458d78b7cf94b9ab2e6/pycparser-3.0.tar.gz"
    sha256 "600f49d217304a5902ac3c37e1281c9fe94e4d0489de643a9504c5cdfdfc6b29"
  end

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/eb/56/b1ba7935a17738ae8453301356628e8147c79dbb825bcbc73dc7401f9846/cffi-2.0.0.tar.gz"
    sha256 "44d1b5909021139fe36001ae048dbdde8214afa20200eda0f64c068cac5d5529"
  end

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/12/45/870e7f4bef50e5f53b9f51d4428aee5290eedf58ba443f16b1ebb7ab8e66/cryptography-48.0.1.tar.gz"
    sha256 "266f4ee051abb2f725b74ef8072b521ce1feacf685a3364fa6a6b45548db791a"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    # Daemon is not running — status exits 0 and prints "not running"
    assert_match "trustmux not running", shell_output("#{bin}/trustmux status")
    # --help should work without a running daemon
    assert_match "usage:", shell_output("#{bin}/trustmux --help")
    # Regression: cryptography must be importable in the bundled venv (GH: #113)
    system libexec/"bin/python3", "-c",
      "from cryptography.hazmat.primitives.asymmetric import ec; ec.generate_private_key(ec.SECP256R1())"
  end
end
