class Trustmux < Formula
  include Language::Python::Virtualenv

  desc "Monitor and interact with tmux/Byobu sessions from your phone"
  homepage "https://trustmux.dev"
  url "https://files.pythonhosted.org/packages/8c/c4/eab6e3d8c48296c61565dd963cca9ade539634e66f1dd608bb8e5ffa8662/trustmux-7.9.tar.gz"
  sha256 "b10d9cce4c38f15b625d125c3a52bba8049fcc441df5066d8a4580f26293ed21"
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
