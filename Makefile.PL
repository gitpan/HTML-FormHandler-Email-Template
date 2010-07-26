use 5.010000;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME              => 'HTML::FormHandler::Email::Template',
    VERSION_FROM      => 'lib/HTML/FormHandler/Email/Template.pm', # finds $VERSION
    PREREQ_PM         => {
    'Moose' => 0,
    'HTML::FormHandler' => 0,
    'HTML::FormHandler::Moose' => 0,
    'HTML::FormHandler::Email' => 0,
    'Template' => 0,
    'Email::Sender::Simple' => 0,
    'Email::Simple::Creator' => 0,
    'Email::Sender::Transport::SMTP' => 0,
    },
    ($] >= 5.005 ?     
      (ABSTRACT_FROM  => 'lib/HTML/FormHandler/Email/Template.pm',
       AUTHOR         => 'aesop <aesop@unicornmob.com>') : ()),
);
