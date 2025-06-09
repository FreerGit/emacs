# Swap left alt and left ctrl
Use your left thumb for ctrl (C-) and right thumb for alt (M-)

```console
foo@bar:~$ setxkbmap -option ctrl:swap_lalt_lctl
```

You can also just add the command to your .profile (or similar)

## Rust
To install `rust-analyzer`
```console
foo@bar:~$ git clone https://github.com/rust-analyzer/rust-analyzer.git -b release
foo@bar:~$ cd rust-analyzer
foo@bar:~$ cargo xtask install --server # will install into $HOME/.cargo/bin
```