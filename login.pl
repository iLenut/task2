use v5.24;
use warnings;

my $username;
my $password;
my $login;
my $file = 'D:\Projects\task2\users.txt';
sub login {
  my $accepted = 0;
  while ($accepted == 0) {
    say "type your username to login";
    $username = <>;
    say "type your password";
    $password = <>;
    chomp($username);
    chomp($password);
    open(SRC, '<', $file) or die $!;
    while(<SRC>) {
      chomp($_);
      my $input = '['.$username.']['.$password.']';
      if (($_ cmp $input) == 0) {
        $accepted = 1;
      }
    }
    close(SRC);
    if ($accepted == 1) {
      say "successfully logged in";
      $login = 1;
      addUser();
    } else {
      say "wrong username or password";
    }
  }
}
login();

sub addUser {
  if ($login == 0) {
    say "You are not logged in. Please login";
    login();
  } else {
    say "write the username you want to add";
    my $accepted = 0;
    while ($accepted == 0) {
      $username = <>;
      chomp($username);
      if ($username =~ m/(^[a-z])|(^[A-Z])/ && $username =~ m/(^[\w]*$)/) {
        $accepted = 1;
        say "username accepted";
        open(DES, '>>', $file);
        $username = '['.$username.']';
        print DES "\n".$username;
        close(DES);
        say "type the password for this user";
      } else {
        say "wrong username - try again";
      }
    }
    $accepted = 0;
    while ($accepted == 0) {
      $password = <>;
      chomp($password);
      if ($password =~ m\(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])\ && ($password =~ /^(.{6,})$/)) {
        $accepted = 1;
        say "password accepted";
        open(DES, '>>', $file);
        $password = '['.$password.']';
        print DES $password;
        close(DES);
      } else {
        say "wrong password - try again";
      }
    }
    say "user added";
    say "type 'add user' to add another user or type 'logout' to logout";
    choose();
  }
}

sub choose {
  my $input = <>;
  chomp($input);
  if (($input cmp 'add user') == 0) {
    addUser();
  } elsif (($input cmp 'logout') == 0) {
    $login = 0;
    say "you're logged out";
    login();
  } else {
    say "try again";
    choose();
  }
}
