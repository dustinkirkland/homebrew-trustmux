class Trustmux < Formula
  include Language::Python::Virtualenv

  desc "Monitor and interact with tmux/Byobu sessions from your phone"
  homepage "https://trustmux.dev"
  url "https://files.pythonhosted.org/packages/c5/70/c3e233cad70ce6cda031f1e09a2d1308c1c7a159e9afeb6f0bb002d2b565/trustmux-7.0a12.tar.gz"
  sha256 "ed11d84a72ad351842bd353b84702686b0617e7fdeb0b9cc82fa8706f1721070"
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
