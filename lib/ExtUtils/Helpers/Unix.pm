package ExtUtils::Helpers::Unix;
{
  $ExtUtils::Helpers::Unix::VERSION = '0.010';
}
use strict;
use warnings FATAL => 'all';

use Exporter 5.57 'import';
our @EXPORT = qw/make_executable split_like_shell/;

use Text::ParseWords 3.24 qw/shellwords/;
use ExtUtils::MakeMaker;

sub make_executable {
	my @files = @_;
	foreach my $file (@files) {
		my $current_mode = (stat $file)[2] + 0;
		ExtUtils::MM->fixin($file) if -T $file;
		chmod $current_mode | oct(111), $file;
	}
};

sub split_like_shell {
  my ($string) = @_;

  return if not defined $string;
  $string =~ s/^\s+|\s+$//g;
  return if not length $string;

  return shellwords($string);
}

1;



=pod

=head1 NAME

ExtUtils::Helpers::Unix - Unix specific helper bits

=head1 VERSION

version 0.010

=for Pod::Coverage make_executable
split_like_shell

=head1 AUTHORS

=over 4

=item *

Ken Williams <kwilliams@cpan.org>

=item *

Leon Timmermans <leont@cpan.org>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2004 by Ken Williams, Leon Timmermans.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

# ABSTRACT: Unix specific helper bits

