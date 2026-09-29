class Trustmux < Formula
  include Language::Python::Virtualenv

  desc "Monitor and interact with tmux/Byobu sessions from your phone"
  homepage "https://trustmux.app"

  url "https://files.pythonhosted.org/packages/38/32/0d154196448111b48f4656c1f4a1279004ac396cdaf1950366d3ce43070c/trustmux-7.20.tar.gz"
  sha256 "85284bff85c9aabc75a80c658ca45f1bbbff5c468c3115ca85a112240ce6b761"
  version "7.20"
  license "GPL-3.0-or-later"

  head "https://github.com/dustinkirkland/byobu.git", branch: "master"

  depends_on "python@3.12"
  depends_on "tmux"
  depends_on "rust" => :build  # required to compile cryptography's Rust extension

  resource "tornado" do
    url "https://files.pythonhosted.org/packages/10/d3/343e5bb989d6515b1646cf3d40135d73f3d5e45339bded401b56cdac24dd/tornado-6.5.8.tar.gz"
    sha256 "9452e1b208a8bd771e2cb1f2ff564985b9b214bdebbe622793e1799e0a6bd23f"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/1b/7d/92392ff7815c21062bea51aa7b87d45576f649f16458d78b7cf94b9ab2e6/pycparser-3.0.tar.gz"
    sha256 "600f49d217304a5902ac3c37e1281c9fe94e4d0489de643a9504c5cdfdfc6b29"
  end

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/9e/ef/008a1939e372c06329a3fce4279c02f328488f3526744906eeec3da7ad5f/cffi-2.1.1.tar.gz"
    sha256 "dd31f52ea1086513bb9df30f8fcee9b8918323ae067a3d5b78bc826a000712be"
  end

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/bb/ad/5d6702db60b1e40b41ef513b6967ff5848f307d50f8449baf1634f5908f1/cryptography-50.0.1.tar.gz"
    sha256 "5dd9bda1c12b4162f6ff568eeb5e0ff956c28d14406e875cfe8a63a2d414ff20"
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
