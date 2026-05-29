class Trustmux < Formula
  include Language::Python::Virtualenv

  desc "Monitor and interact with tmux/Byobu sessions from your phone"
  homepage "https://trustmux.dev"
  url "https://files.pythonhosted.org/packages/59/ab/89683701616374c988d9348a386454d0e7cb076f73085196de8a7d9c40b1/trustmux-7.1rc1.tar.gz"
  sha256 "8082d6738035579e76adea1ce75ba25316c97d47009100b5d49ce008547ea982"
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
