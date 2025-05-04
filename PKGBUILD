# Maintainer: SilverX <serainox@gmail.com>
pkgname=bash-armor
pkgver=1.0
pkgrel=1
pkgdesc="BashArmor: Bash obfuscator with repeatable PHP+fzf shell frontend"
arch=('any')
url="https://github.com/Szmelc-INC/BashArmor"
license=('MIT')
depends=('php' 'fzf' 'tree' 'bash')
makedepends=('git')
source=("git+$url.git#branch=main")
md5sums=('SKIP')

package() {
  cd "$srcdir/BashArmor"

  # Install main script wrapper
  install -Dm755 exec.sh "$pkgdir/usr/bin/bash-armor"

  # Install PHP logic + .bin contents
  install -Dm644 exec.php "$pkgdir/usr/share/bash-armor/exec.php"
  install -d "$pkgdir/usr/share/bash-armor/.bin"
  install -m644 .bin/* "$pkgdir/usr/share/bash-armor/.bin/"

  # Modify exec.sh to always run from its shared dir
  sed -i 's|php exec.php|php /usr/share/bash-armor/exec.php|' "$pkgdir/usr/bin/bash-armor"
}
