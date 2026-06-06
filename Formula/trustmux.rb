class Trustmux < Formula
  include Language::Python::Virtualenv

  desc "Monitor and interact with tmux/Byobu sessions from your phone"
  homepage "https://trustmux.dev"
  url "https://files.pythonhosted.org/packages/3f/40/85c24caf43eea9ec6779c085a095c0bd35e1f0fd086fef2be3f1276299b4/trustmux-7.8.tar.gz"
  sha256 "e98a2a44b63023c5ee8108bb55173fd84acc07bd1a053a947d60420dccd8a4b5"
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
