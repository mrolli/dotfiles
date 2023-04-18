# My tilde, my dotti, the muse of my creation

These dotfiles are highly opinionated and shamelessly copied from others and eventually
adjusted to my needs and foremost to my taste.

## Installation

To install/update, make sure ansible is installed and then run the `main.yml`
playbook:

 `ansible-playbook -i ansible/hosts ansible/main.yml`

This playbook in principle manages `~/.config` and adds symlinks for each
object in the directory `config/` there or to `~/`. It's possible to add object
to the list `dotfiles_omit_configs` to have them skipped when creating symlinks.
See `ansible/main.yml` for the details.

## Thanks for their inspirations over the years…

* [Folke Maitre](https://github.com/folke) for his contributions to the Neovim
  ecosystem and for the nudge to also use Ansible for the dotfiles
* [Jeff Geerling](https://github.com/geerlingguy) for his book [Ansible for DevOps](https://www.ansiblefordevops.com)
  and the [mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook)
* [Mathias Bynens](https://mths.be/) for his bodacious
  [dotfiles](https://github.com/mathiasbynens/dotfiles), his prompt style and his
  work on [.macos](https://github.com/mathiasbynens/dotfiles/blob/main/.macos)
* [Kevin Suttle](http://kevinsuttle.com/) for his
  [dotfiles repository](https://github.com/kevinSuttle/dotfiles) and his work on
  [macOS-Defaults project](https://github.com/kevinSuttle/macOS-Defaults)
* and many more I do not remember anymore
