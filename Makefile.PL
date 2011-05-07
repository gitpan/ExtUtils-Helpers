
use strict;
use warnings;

BEGIN { require 5.006; }

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'Various portability utilities for module builders',
  'AUTHOR' => 'Ken Williams <kwilliams@cpan.org>, Leon Timmermans <leont@cpan.org>',
  'BUILD_REQUIRES' => {
    'Config' => '0',
    'Cwd' => '0',
    'Test::More' => '0'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.30'
  },
  'DISTNAME' => 'ExtUtils-Helpers',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'ExtUtils::Helpers',
  'PREREQ_PM' => {
    'Exporter' => '5.57',
    'File::Basename' => '0',
    'File::Path' => '0',
    'File::Spec::Functions' => '0',
    'Pod::Man' => '0',
    'Text::ParseWords' => '3.24'
  },
  'VERSION' => '0.007',
  'test' => {
    'TESTS' => 't/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



