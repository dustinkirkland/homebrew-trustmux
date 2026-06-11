class Trustmux < Formula
  include Language::Python::Virtualenv

  desc "Monitor and interact with tmux/Byobu sessions from your phone"
  homepage "https://trustmux.dev"
  url "https://files.pythonhosted.org/packages/d0/47/e2b83cda200dd4cd1a9917b1ad606f1654c13aa087363f461ee1f258aa66/trustmux-7.11.tar.gz"
  sha256 "3013240a1ed1235e7adeda4109bc886cf00f5021df7aec10c2e333cf0dd7106a"
  license "GPL-3.0-or-later"

  depends_on "python@3.12"
  depends_on "tmux"

  resource "tornado" do
    url "https://files.pythonhosted.org/packages/50/57/6d7303a77ae439d9189108f76c0c4fd89ee5e2cc8387bffb55232565c4ed/tornado-6.5.6.tar.gz"
    sha256 "9a365179fe8ff6b8766f602c0f67c185d778193e9bdd828b19f0b6ed7764177d"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "trustmux", shell_output("#{bin}/trustmux --version")
  end
end
